WITH labor AS (
  SELECT
    date,
    captain,
    SUM(labor) FILTER (WHERE "laborType" = 'Move' AND captain = ANY(regexp_split_to_array(shift_team, '\s*,\s*'))) AS move_labor,
    SUM(labor) FILTER (WHERE CASE WHEN {{ include_utility.value }} = true THEN "laborType" IN ('Junk', 'Utility') ELSE "laborType" = 'Junk' END AND captain = ANY(regexp_split_to_array(shift_team, '\s*,\s*'))) AS junk_labor
  FROM labor_data
  WHERE captain IS NOT NULL
  GROUP BY date, captain
),
revenue AS (
  SELECT
    "Job Date" AS date,
    "Captain Name" AS captain,
    SUM(grand_total_numeric) FILTER (WHERE "Category" IN ('Move Labor', 'Moving'))  AS move_revenue,
    SUM(grand_total_numeric) FILTER (WHERE "Category" IN ('Junk Removal', 'Labor')) AS junk_revenue,
    COUNT("Job ID") FILTER (WHERE "Category" IN ('Move Labor', 'Moving'))           AS move_jobs,
    COUNT("Job ID") FILTER (WHERE "Category" IN ('Junk Removal', 'Labor'))          AS junk_jobs
  FROM hunkware_rev
  WHERE
    "Captain Name" IS NOT NULL
    AND "Status" IN ('Completed', 'Closed')
    AND CASE
      WHEN "Category" IN ('Move Labor', 'Moving') THEN
        CASE
          -- permanently set to false, used include_out_of_state.value
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
  SELECT date, captain FROM labor
  UNION
  SELECT date, captain FROM revenue
  UNION
  SELECT date, name AS captain FROM tips WHERE name IS NOT NULL
),
by_captain_by_day AS (
  SELECT
    ak.date,
    ak.captain,

    -- Move metrics
    ROUND(COALESCE(l.move_labor, 0) +
      -- permanently set to false, used include_out_of_state.value
      CASE WHEN false = true THEN COALESCE(t.oos_labor, 0) ELSE 0 END,
    2) AS move_labor,
    CASE WHEN {{ include_commissions.value }} = true THEN COALESCE(t.move_commissions, 0) ELSE 0 END AS move_commission,
    COALESCE(r.move_revenue, 0) AS move_revenue,
    COALESCE(r.move_jobs, 0) AS move_jobs,

    -- Junk metrics
    ROUND(COALESCE(l.junk_labor, 0), 2) AS junk_labor,
    COALESCE(r.junk_revenue, 0) AS junk_revenue,
    COALESCE(r.junk_jobs, 0) AS junk_jobs
  FROM all_keys ak
  LEFT JOIN labor l ON ak.date = l.date AND ak.captain = l.captain
  LEFT JOIN revenue r ON ak.date = r.date AND ak.captain = r.captain
  LEFT JOIN tips t ON ak.date = t.date AND ak.captain = t.name
  WHERE ak.captain IS NOT NULL AND ak.captain != ''
)
SELECT
  captain,
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
WHERE date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }} AND captain != ''
GROUP BY captain
HAVING SUM(move_labor) != 0
  OR SUM(move_commission) != 0
  OR SUM(move_revenue) != 0
  OR SUM(move_jobs) != 0
  OR SUM(junk_labor) != 0
  OR SUM(junk_revenue) != 0
  OR SUM(junk_jobs) != 0
ORDER BY split_part(captain, ' ', -1);