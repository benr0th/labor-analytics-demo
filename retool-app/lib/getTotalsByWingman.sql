WITH labor AS (
  SELECT
    ld.date,
    btrim(member) AS name,
    ld.captain,
    SUM(ld.labor) FILTER (WHERE ld."laborType" = 'Move') AS move_labor,
    SUM(ld.labor) FILTER (
      WHERE CASE
        WHEN {{ include_utility.value }} = true THEN ld."laborType" IN ('Junk', 'Utility')
        ELSE ld."laborType" = 'Junk'
      END
    ) AS junk_labor,
    COUNT(*) FILTER (WHERE ld."laborType" = 'Move' AND btrim(member) = ld.name) AS move_jobs,
    COUNT(*) FILTER (
      WHERE CASE
        WHEN {{ include_utility.value }} = true THEN ld."laborType" IN ('Junk', 'Utility')
        ELSE ld."laborType" = 'Junk'
      END
      AND btrim(member) = ld.name
    ) AS junk_jobs
  FROM labor_data ld
  CROSS JOIN LATERAL unnest(regexp_split_to_array(ld.shift_team, '\s*,\s*')) AS member
  WHERE ld.captain IS NOT NULL
    AND ld.name = ANY(regexp_split_to_array(ld.shift_team, '\s*,\s*'))
    AND btrim(member) <> ''
  GROUP BY ld.date, btrim(member), ld.captain
),
revenue AS (
  SELECT
    "Job Date" AS date,
    "Captain Name" AS captain,
    SUM(grand_total_numeric) FILTER (WHERE "Category" IN ('Move Labor', 'Moving'))  AS move_revenue,
    SUM(grand_total_numeric) FILTER (WHERE "Category" IN ('Junk Removal', 'Labor')) AS junk_revenue
    -- COUNT("Job ID") FILTER (WHERE "Category" IN ('Move Labor', 'Moving'))           AS move_jobs,
    -- COUNT("Job ID") FILTER (WHERE "Category" IN ('Junk Removal', 'Labor'))          AS junk_jobs
  FROM hunkware_rev
  WHERE
    "Captain Name" IS NOT NULL
    AND "Status" IN ('Completed', 'Closed')
    AND CASE
      WHEN "Category" IN ('Move Labor', 'Moving') THEN
        CASE
          -- permanently set to false, was include_out_of_state.value 
          WHEN false = true THEN true
          ELSE "Destination State/Prov" = 'FL'
            OR "Destination State/Prov" IS NULL
            OR "Destination State/Prov" = ''
        END
      ELSE true
    END
  GROUP BY "Job Date", "Captain Name"
),
-- Tips/commissions per captain per date
tips AS (
  SELECT
    date,
    name,
    SUM(COALESCE(out_of_state_pay, 0)) AS oos_labor,
    SUM(COALESCE(commission, 0)) AS move_commissions
  FROM tips_and_commissions
  WHERE name IS NOT NULL
  GROUP BY date, name
),
all_keys AS (
  -- wingman + their captain for each shift (drives labor AND revenue)
  SELECT date, name, captain FROM labor
  UNION
  -- wingmen who only have tips that day, no shift row → no captain, no revenue
  SELECT t.date, t.name, NULL::text AS captain
  FROM tips t
  WHERE t.name IS NOT NULL
    AND NOT EXISTS (
      SELECT 1 FROM labor l
      WHERE l.date = t.date AND l.name = t.name
    )
),
by_captain_by_day AS (
  SELECT
    ak.date,
    ak.name,
    ak.captain,

    -- Move metrics
    ROUND(COALESCE(l.move_labor, 0) +
      -- permanently set to false, was include_out_of_state.value 
      CASE WHEN false = true THEN COALESCE(t.oos_labor, 0) ELSE 0 END,
    2) AS move_labor,
    CASE WHEN {{ include_commissions.value }} = true THEN COALESCE(t.move_commissions, 0) ELSE 0 END AS move_commission,
    COALESCE(r.move_revenue, 0) AS move_revenue,
    COALESCE(l.move_jobs, 0) AS move_jobs,

    -- Junk metrics
    ROUND(COALESCE(l.junk_labor, 0), 2) AS junk_labor,
    COALESCE(r.junk_revenue, 0) AS junk_revenue,
    COALESCE(l.junk_jobs, 0) AS junk_jobs
  FROM all_keys ak
  LEFT JOIN labor   l ON ak.date = l.date AND ak.name = l.name
                      AND ak.captain IS NOT DISTINCT FROM l.captain
  LEFT JOIN revenue r ON ak.date = r.date AND ak.captain = r.captain
  LEFT JOIN tips    t ON ak.date = t.date AND ak.name = t.name
  WHERE ak.name IS NOT NULL AND ak.name != ''
),
wingmen AS (
  SELECT DISTINCT name
  FROM labor_data
  WHERE job_title LIKE '%Wingman%'
  AND date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
)
SELECT
  name,
  SUM(move_labor) AS move_labor,
  SUM(move_commission) AS move_commission,
  SUM(move_revenue) AS move_revenue,
  SUM(move_jobs) AS move_jobs,
  CASE WHEN SUM(move_revenue) > 0 THEN (SUM(move_labor) + CASE WHEN {{ include_commissions.value }} = true THEN SUM(move_commission) ELSE 0 END) / SUM(move_revenue) ELSE NULL END AS move_labor_pct,
  CASE WHEN SUM(move_jobs) > 0 THEN SUM(move_revenue) / SUM(move_jobs) ELSE NULL END AS move_ajs,
  SUM(junk_labor) AS junk_labor,
  SUM(junk_revenue) AS junk_revenue,
  SUM(junk_jobs) AS junk_jobs,
  CASE WHEN SUM(junk_revenue) > 0 THEN SUM(junk_labor) / SUM(junk_revenue) ELSE NULL END AS junk_labor_pct,
  CASE WHEN SUM(junk_jobs) > 0 THEN SUM(junk_revenue) / SUM(junk_jobs) ELSE NULL END AS junk_ajs
FROM by_captain_by_day
WHERE date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
  AND name IN (SELECT name FROM wingmen)
GROUP BY name
HAVING SUM(move_labor) != 0
  OR SUM(move_commission) != 0
  OR SUM(move_revenue) != 0
  OR SUM(move_jobs) != 0
  OR SUM(junk_labor) != 0
  OR SUM(junk_revenue) != 0
  OR SUM(junk_jobs) != 0
ORDER BY split_part(name, ' ', -1);