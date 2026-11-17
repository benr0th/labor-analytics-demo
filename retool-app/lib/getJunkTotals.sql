WITH
  labor AS (
    SELECT
      SUM(labor) FILTER (
        WHERE
          CASE
            WHEN {{ false }} = true THEN "laborType" IN ('Junk', 'Utility')
            ELSE "laborType" = 'Junk'
          END
        AND date between {{ tips_date_start.value }} AND {{ tips_date_end.value }}
      ) AS junk_labor
    FROM
      "labor_data"
  ),
  revenue AS (
    SELECT
      SUM(grand_total_numeric) FILTER (
        WHERE
          "Category" IN ('Junk Removal', 'Labor')
        AND "Job Date" between {{ tips_date_start.value }} AND {{ tips_date_end.value }}
      ) AS junk_revenue
    FROM
      "hunkware_rev"
    WHERE
      "Status" IN ('Completed', 'Closed')
  )
SELECT
  -- Junk metrics
  ROUND(COALESCE(l.junk_labor, 0), 2) AS junk_labor,
  COALESCE(r.junk_revenue, 0) AS junk_revenue
FROM
  labor l
  FULL OUTER JOIN revenue r ON true
