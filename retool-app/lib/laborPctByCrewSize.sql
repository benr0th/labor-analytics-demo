WITH labor AS (
    SELECT
        date,
        captain,
        name,
        hunkware_id,
        shift_team,
        COALESCE(hunkware_id, 'CAPTAIN:' || captain || ':' || date::text) AS job_key,
        array_length(string_to_array(shift_team, ','), 1) AS person_count,
        SUM(labor) AS move_labor
    FROM labor_data
    WHERE shift_team IS NOT NULL AND shift_team != ''
      AND "laborType" = 'Move'
      AND captain IS NOT NULL
      AND name IS NOT NULL
      AND date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
    GROUP BY date, captain, name, hunkware_id, shift_team
),
revenue AS (
    SELECT
        "Job Date" AS date,
        "Captain Name" AS captain,
        "Job ID",
        grand_total_numeric AS move_revenue
    FROM hunkware_rev
    WHERE "Captain Name" IS NOT NULL
      AND "Status" IN ('Completed', 'Closed')
      AND "Category" IN ('Move Labor', 'Moving')
      AND "Job Date" BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
      AND (
        {{ include_out_of_state.value }} = true
        OR "Destination State/Prov" = 'FL'
        OR "Destination State/Prov" IS NULL
        OR "Destination State/Prov" = ''
      )
),
tips AS (
    SELECT
        date,
        name,
        SUM(COALESCE(out_of_state_pay, 0)) AS oos_labor,
        SUM(COALESCE(commission, 0)) AS move_commissions
    FROM tips_and_commissions
    WHERE name IS NOT NULL
      AND date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
    GROUP BY date, name
),
combined AS (
    SELECT
        l.date,
        l.captain,
        l.job_key,
        l.person_count,
        l.move_labor
            + CASE WHEN {{ include_out_of_state.value }} = true THEN COALESCE(t.oos_labor, 0) ELSE 0 END
            + CASE WHEN {{ include_commissions.value }} = true THEN COALESCE(t.move_commissions, 0) ELSE 0 END
            AS move_labor,
        (
            SELECT MAX(r.move_revenue)
            FROM revenue r
            WHERE r.date = l.date
              AND r.captain = l.captain
              AND (
                l.hunkware_id IS NULL
                OR r."Job ID"::text = ANY(
                    SELECT trim(both ' #' FROM id)
                    FROM unnest(regexp_split_to_array(l.hunkware_id, '\s*[,/]\s*')) AS id
                )
              )
        ) AS move_revenue
    FROM labor l
    LEFT JOIN tips t ON l.date = t.date AND l.name = t.name
),
per_job AS (
    SELECT
        person_count,
        job_key,
        SUM(move_labor) AS total_labor,
        MAX(move_revenue) AS total_revenue
    FROM combined
    GROUP BY person_count, job_key
)
SELECT
    person_count,
    COUNT(*) AS number_of_jobs,
    COUNT(*) FILTER (WHERE total_revenue IS NOT NULL) AS jobs_with_revenue,
    ROUND(SUM(total_labor)::numeric, 2) AS total_labor,
    SUM(total_revenue) AS total_revenue,
    ROUND(SUM(total_labor)::numeric / NULLIF(SUM(total_revenue), 0), 4) AS "labor %"
FROM per_job
GROUP BY person_count
ORDER BY person_count;