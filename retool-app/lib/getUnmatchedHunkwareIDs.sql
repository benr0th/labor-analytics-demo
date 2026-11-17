SELECT
    combined.hunkware_id,
    combined.date,
    combined.shift_team,
    combined."laborType",
    combined.reason,
    COALESCE(f.fixed, false) AS fixed,
    COALESCE(f.notes, '') AS notes
FROM (
    SELECT * FROM (
        SELECT DISTINCT ON (ld.hunkware_id)
            ld.hunkware_id,
            ld.date,
            ld.shift_team,
            ld."laborType",
            'ID does not exist in Revenue sheet' AS reason
        FROM labor_data ld
        WHERE ld.date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
          AND ld.hunkware_id IS NOT NULL
          AND ld."laborType" IN ('Move', 'Junk', 'Utility')
          AND NOT EXISTS (
            SELECT 1
            FROM hunkware_rev hr
            WHERE hr."Job ID"::text = ANY(
                SELECT trim(both ' #' FROM id)
                FROM unnest(regexp_split_to_array(ld.hunkware_id, '\s*[,/]\s*')) AS id
            )
          )
        ORDER BY ld.hunkware_id
    ) q1

    UNION ALL

    SELECT * FROM (
        SELECT DISTINCT ON (ld.hunkware_id)
            ld.hunkware_id,
            ld.date,
            ld.shift_team,
            ld."laborType",
            'Incorrect Job ID' AS reason
        FROM labor_data ld
        WHERE ld.date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
          AND ld.hunkware_id IS NOT NULL
          AND EXISTS (
            SELECT 1
            FROM hunkware_rev hr
            WHERE hr."Job ID"::text = ANY(
                SELECT trim(both ' #' FROM id)
                FROM unnest(regexp_split_to_array(ld.hunkware_id, '\s*[,/]\s*')) AS id
            )
              AND hr."Status" NOT IN ('Closed', 'Completed')
          )
          AND NOT EXISTS (
            SELECT 1
            FROM hunkware_rev hr
            WHERE hr."Job ID"::text = ANY(
                SELECT trim(both ' #' FROM id)
                FROM unnest(regexp_split_to_array(ld.hunkware_id, '\s*[,/]\s*')) AS id
            )
              AND (hr."Captain Name" IS NOT NULL AND hr."Captain Name" <> '')
              AND hr."Status" IN ('Closed', 'Completed')
          )
        ORDER BY ld.hunkware_id
    ) q2

    UNION ALL

        SELECT * FROM (
        SELECT DISTINCT ON (ld.shift_team)
            ld.hunkware_id,
            ld.date,
            ld.shift_team,
            ld."laborType",
            'Duplicate ID' AS reason
        FROM labor_data ld
        INNER JOIN (
            SELECT hunkware_id
            FROM labor_data
            WHERE date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
              AND hunkware_id IS NOT NULL
            GROUP BY hunkware_id
            HAVING COUNT(DISTINCT shift_team) > 1
              AND COUNT(DISTINCT date) > 1
        ) conflicts ON ld.hunkware_id = conflicts.hunkware_id
        WHERE ld.date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
          AND ld.captain IS NULL
          AND ld.linked_job = false
        ORDER BY ld.shift_team
    ) q3

    UNION ALL

    SELECT * FROM (
        SELECT DISTINCT ON (ld.hunkware_id)
            ld.hunkware_id,
            ld.date,
            ld.shift_team,
            ld."laborType",
            'Captain name not in Shift Team' AS reason
        FROM labor_data ld
        WHERE ld.date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
          AND ld.hunkware_id IS NOT NULL
          AND ld."laborType" IN ('Move', 'Junk', 'Utility')
          AND EXISTS (
            SELECT 1
            FROM hunkware_rev hr
            WHERE hr."Job ID"::text = ANY(
                SELECT regexp_replace(trim(id), '^[\s#]+|[\s#]+$', '', 'g')
                FROM unnest(regexp_split_to_array(ld.hunkware_id, '\s*[,/]\s*')) AS id
            )
              AND hr."Status" IN ('Closed', 'Completed')
              AND hr."Captain Name" IS NOT NULL
              AND hr."Captain Name" <> ''
              AND (
                ld.shift_team IS NULL
                OR ld.shift_team = ''
                OR NOT EXISTS (
                    SELECT 1
                    FROM unnest(regexp_split_to_array(ld.shift_team, '\s*,\s*')) AS team_member
                    WHERE LOWER(trim(team_member)) = LOWER(trim(hr."Captain Name"))
                )
              )
          )
        ORDER BY ld.hunkware_id
    ) q4
            
    UNION ALL

    SELECT * FROM (
        SELECT DISTINCT ON (ld.date, ld.shift_team)
            ld.hunkware_id,
            ld.date,
            ld.shift_team,
            ld."laborType",
            'Hunkware ID is missing' AS reason
        FROM labor_data ld
        WHERE ld.date BETWEEN {{ date_range_start.value }} AND {{ date_range_end.value }}
          AND ld.hunkware_id IS NULL
          AND (ld.captain IS NULL OR ld.captain = '')
          AND ld."laborType" IN ('Move')
        ORDER BY ld.date, ld.shift_team
    ) q5
) combined
LEFT JOIN connecteam_discrepancies f
    ON f.hunkware_id IS NOT DISTINCT FROM combined.hunkware_id
   AND f.date = combined.date
   AND f.reason = combined.reason
ORDER BY combined.hunkware_id;