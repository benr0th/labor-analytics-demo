WITH labor AS (
  SELECT
    date,
    SUM(labor) FILTER (WHERE "laborType" = 'Move') AS move_labor,
    SUM(labor) FILTER (WHERE CASE WHEN {{ include_utility.value }} = true THEN "laborType" IN ('Junk', 'Utility') ELSE "laborType" = 'Junk' END) AS junk_labor
  FROM labor_data
  GROUP BY date
),
revenue AS (
  SELECT
    "Job Date" AS date,
    SUM(grand_total_numeric) FILTER (WHERE "Category" IN ('Move Labor', 'Moving'))  AS move_revenue,
    SUM(grand_total_numeric) FILTER (WHERE "Category" IN ('Junk Removal', 'Labor')) AS junk_revenue,
    COUNT("Job ID") FILTER (WHERE "Category" IN ('Move Labor', 'Moving'))           AS move_jobs,
    COUNT("Job ID") FILTER (WHERE "Category" IN ('Junk Removal', 'Labor'))          AS junk_jobs
  FROM hunkware_rev
  WHERE
    "Status" IN ('Completed', 'Closed')
    AND CASE
      WHEN "Category" IN ('Move Labor', 'Moving') THEN
        CASE
          WHEN {{ include_out_of_state.value }} = true THEN true
          ELSE "Destination State/Prov" = 'FL'
            OR "Destination State/Prov" IS NULL
            OR "Destination State/Prov" = ''
        END
      ELSE true
    END
  GROUP BY "Job Date"
),
oos_pay AS (
  SELECT
    date,
    SUM(COALESCE(out_of_state_pay, 0)) AS oos_labor
  FROM tips_and_commissions
  GROUP BY date
)
SELECT
  COALESCE(l.date, r.date) AS date,

  -- Move metrics
  ROUND(COALESCE(l.move_labor, 0) +
    CASE WHEN {{ include_out_of_state.value }} = true THEN COALESCE(o.oos_labor, 0) ELSE 0 END,
  2) AS move_labor,
  COALESCE(r.move_revenue, 0) AS move_revenue,
  ROUND(
    (COALESCE(l.move_labor, 0) + CASE WHEN {{ include_out_of_state.value }} = true THEN COALESCE(o.oos_labor, 0) ELSE 0 END) /
    NULLIF(COALESCE(r.move_revenue, 0), 0),
  4) AS move_labor_pct,
  COALESCE(r.move_jobs, 0) AS move_jobs,

  -- Junk metrics
  ROUND(COALESCE(l.junk_labor, 0), 2) AS junk_labor,
  COALESCE(r.junk_revenue, 0) AS junk_revenue,
  ROUND(COALESCE(l.junk_labor, 0) / NULLIF(COALESCE(r.junk_revenue, 0), 0), 4) AS junk_labor_pct,
  COALESCE(r.junk_jobs, 0) AS junk_jobs,

  -- Overall metrics
  ROUND(COALESCE(l.move_labor, 0) + COALESCE(l.junk_labor, 0) +
    CASE WHEN {{ include_out_of_state.value }} = true THEN COALESCE(o.oos_labor, 0) ELSE 0 END,
  2) AS overall_labor,
  COALESCE(r.move_revenue, 0) + COALESCE(r.junk_revenue, 0) AS overall_revenue,
  ROUND(
    (COALESCE(l.move_labor, 0) + COALESCE(l.junk_labor, 0) + CASE WHEN {{ include_out_of_state.value }} = true THEN COALESCE(o.oos_labor, 0) ELSE 0 END) /
    NULLIF(COALESCE(r.move_revenue, 0) + COALESCE(r.junk_revenue, 0), 0),
  4) AS overall_labor_pct,
  COALESCE(r.move_jobs, 0) + COALESCE(r.junk_jobs, 0) AS overall_jobs

FROM labor l
FULL OUTER JOIN revenue r ON l.date = r.date
LEFT JOIN oos_pay o ON COALESCE(l.date, r.date) = o.date
WHERE COALESCE(l.date, r.date) BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
ORDER BY date ASC;