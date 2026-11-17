WITH normalized AS (
    SELECT
        name,
        date,
        shift_team,
        truck,
        start_time,
        end_time,
        job_title,
        captain,
        (SELECT array_agg(trim(n) ORDER BY trim(n))
         FROM unnest(string_to_array(shift_team, ',')) AS n) AS team_members
    FROM labor_data
    WHERE date between {{ date_range_start.value }} and {{ date_range_end.value }}
),
qualifying AS (
    SELECT date, shift_team, team_members
    FROM normalized
    WHERE name = ANY(team_members)
    GROUP BY date, shift_team, team_members
    HAVING array_agg(name ORDER BY name) = team_members
),
medians AS (
    SELECT
        n.date,
        n.shift_team,
        ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY n.start_time))::bigint AS median_start_time,
        ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY n.end_time))::bigint   AS median_end_time
    FROM normalized n
    JOIN qualifying q
      ON q.date = n.date
     AND q.shift_team = n.shift_team
    WHERE n.name = ANY(n.team_members)
    GROUP BY n.date, n.shift_team
),
captains AS (
    SELECT
        n.date,
        n.shift_team,
        n.start_time AS captain_start_time,
        n.end_time   AS captain_end_time
    FROM normalized n
    JOIN qualifying q
      ON q.date = n.date
     AND q.shift_team = n.shift_team
    WHERE n.name = n.captain
      AND n.name = ANY(n.team_members)
)
SELECT
    n.name,
    n.date,
    n.shift_team,
    n.truck,
    n.job_title,
    n.captain,
    to_char(to_timestamp(n.start_time)        AT TIME ZONE 'America/New_York', 'FMHH12:MI AM') AS start_time,
    to_char(to_timestamp(n.end_time)          AT TIME ZONE 'America/New_York', 'FMHH12:MI AM') AS end_time,
    to_char(to_timestamp(m.median_start_time) AT TIME ZONE 'America/New_York', 'FMHH12:MI AM') AS median_start_time,
    to_char(to_timestamp(m.median_end_time)   AT TIME ZONE 'America/New_York', 'FMHH12:MI AM') AS median_end_time,
    CASE
        WHEN n.start_time >= m.median_start_time
            THEN '+' || ROUND((n.start_time - m.median_start_time) / 60.0, 1) || ' minutes'
        ELSE      '-' || ROUND((m.median_start_time - n.start_time) / 60.0, 1) || ' minutes'
    END AS start_deviation,
    CASE
        WHEN n.end_time >= m.median_end_time
            THEN '+' || ROUND((n.end_time - m.median_end_time) / 60.0, 1) || ' minutes'
        ELSE      '-' || ROUND((m.median_end_time - n.end_time) / 60.0, 1) || ' minutes'
    END AS end_deviation,
    (ABS(n.start_time - m.median_start_time) > 900) AS start_deviates,
    (ABS(n.end_time   - m.median_end_time)   > 900) AS end_deviates,
    ((n.end_time - n.start_time) / 3600)::text || ':' || LPAD((((n.end_time - n.start_time) % 3600) / 60)::text, 2, '0') AS "Shift Hours",
    CASE
        WHEN n.name = n.captain THEN 'N/A'
        WHEN n.start_time >= c.captain_start_time
            THEN '+' || ROUND((n.start_time - c.captain_start_time) / 60.0, 1) || ' minutes'
        ELSE      '-' || ROUND((c.captain_start_time - n.start_time) / 60.0, 1) || ' minutes'
    END AS captain_start_deviation,
    CASE
        WHEN n.name = n.captain THEN 'N/A'
        WHEN n.end_time >= c.captain_end_time
            THEN '+' || ROUND((n.end_time - c.captain_end_time) / 60.0, 1) || ' minutes'
        ELSE      '-' || ROUND((c.captain_end_time - n.end_time) / 60.0, 1) || ' minutes'
    END AS captain_end_deviation,
    CASE WHEN n.name = n.captain THEN NULL ELSE (ABS(n.start_time - c.captain_start_time) > 900) END AS captain_start_deviates,
    CASE WHEN n.name = n.captain THEN NULL ELSE (ABS(n.end_time   - c.captain_end_time)   > 900) END AS captain_end_deviates,
    DENSE_RANK() OVER (ORDER BY n.date, n.shift_team) AS group_index
FROM normalized n
JOIN qualifying q
  ON q.date = n.date
 AND q.shift_team = n.shift_team
JOIN medians m
  ON m.date = n.date
 AND m.shift_team = n.shift_team
JOIN captains c
  ON c.date = n.date
 AND c.shift_team = n.shift_team
WHERE n.name = ANY(n.team_members)
ORDER BY n.date, n.shift_team, n.name;