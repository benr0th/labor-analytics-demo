WITH bonus_goal AS (
  SELECT (value::numeric) AS goal
  FROM table_settings
  WHERE key = 'bonus_goal'
),
labor AS (
  SELECT
    date,
    captain,
    SUM(labor) FILTER (WHERE "laborType" = 'Junk' AND captain = ANY(regexp_split_to_array(shift_team, '\s*,\s*'))) AS junk_labor
  FROM labor_data
  WHERE captain IS NOT NULL
  GROUP BY date, captain
),
revenue AS (
  SELECT
    "Job Date" AS date,
    "Captain Name" AS captain,
    SUM(grand_total_numeric) FILTER (WHERE "Category" IN ('Junk Removal', 'Labor')) AS junk_revenue,
    COUNT("Job ID") FILTER (WHERE "Category" IN ('Junk Removal', 'Labor'))          AS junk_jobs
  FROM hunkware_rev
  WHERE
    "Captain Name" IS NOT NULL
    AND "Status" IN ('Completed', 'Closed')
  GROUP BY "Job Date", "Captain Name"
),
-- Overall junk labor across ALL workers in the date range (not just captains with jobs)
overall_junk_labor AS (
  SELECT SUM(labor) AS total
  FROM labor_data
  WHERE "laborType" = 'Junk'
    AND date BETWEEN {{ date_start }} AND {{ date_end }}
),
-- Overall junk revenue across ALL jobs in the date range (not just captains with jobs)
overall_junk_revenue AS (
  SELECT SUM(grand_total_numeric) AS total
  FROM hunkware_rev
  WHERE "Status" IN ('Completed', 'Closed')
    AND "Category" IN ('Junk Removal', 'Labor')
    AND "Job Date" BETWEEN {{ date_start }} AND {{ date_end }}
),
by_captain AS (
  SELECT
    COALESCE(l.captain, r.captain) AS captain,
    SUM(COALESCE(l.junk_labor, 0)) AS junk_labor,
    SUM(COALESCE(r.junk_revenue, 0)) AS junk_revenue,
    SUM(COALESCE(r.junk_jobs, 0)) AS junk_jobs
  FROM labor l
  FULL JOIN revenue r ON l.date = r.date AND l.captain = r.captain
  WHERE COALESCE(l.captain, r.captain) IS NOT NULL
    AND COALESCE(l.date, r.date) BETWEEN {{ date_start }} AND {{ date_end }}
  GROUP BY COALESCE(l.captain, r.captain)
  HAVING SUM(COALESCE(r.junk_jobs, 0)) > 0
),
with_bonus AS (
  SELECT
    bc.*,
    bg.goal AS bonus_goal,
    CASE WHEN bc.junk_revenue > 0 THEN bc.junk_labor / bc.junk_revenue ELSE NULL END AS junk_labor_pct,
    CASE WHEN bc.junk_jobs > 0 THEN bc.junk_revenue / bc.junk_jobs ELSE NULL END AS junk_ajs,
    CASE
      WHEN bc.junk_revenue > 0 AND bc.junk_labor / bc.junk_revenue < bg.goal
      THEN (bg.goal - bc.junk_labor / bc.junk_revenue) * bc.junk_revenue
      ELSE NULL
    END AS raw_bonus
  FROM by_captain bc
  CROSS JOIN bonus_goal bg
),
totals AS (
  SELECT SUM(raw_bonus) AS total_raw_bonus
  FROM with_bonus
),
threshold AS (
  SELECT (bg.goal * COALESCE(ojr.total, 0)) - COALESCE(ojl.total, 0) AS adj_bonus_threshold
  FROM bonus_goal bg
  CROSS JOIN overall_junk_revenue ojr
  CROSS JOIN overall_junk_labor ojl
)
SELECT
  w.captain,
  ROUND(w.junk_labor, 2) AS junk_labor,
  ROUND(w.junk_revenue, 2) AS junk_revenue,
  w.junk_jobs,
  ROUND(w.junk_labor_pct, 4) AS junk_labor_pct,
  ROUND(w.junk_ajs, 2) AS junk_ajs,
  ROUND(w.raw_bonus, 2) AS raw_bonus,
  ROUND(
    CASE
      WHEN t.total_raw_bonus >= th.adj_bonus_threshold AND th.adj_bonus_threshold > 0
      THEN (th.adj_bonus_threshold / t.total_raw_bonus) * w.raw_bonus
      ELSE w.raw_bonus
    END,
  2) AS adjusted_bonus
FROM with_bonus w
CROSS JOIN totals t
CROSS JOIN threshold th
ORDER BY split_part(w.captain, ' ', -1);