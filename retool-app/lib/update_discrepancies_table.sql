INSERT INTO connecteam_discrepancies (hunkware_id, date, shift_team, labor_type, reason, fixed, notes, updated_at)
SELECT
    (elem->>'hunkware_id')::text,
    (elem->>'date')::date,
    (elem->>'shift_team')::text,
    (elem->>'labor_type')::text,
    (elem->>'reason')::text,
    (elem->>'fixed')::boolean,
    (elem->>'notes')::text,
    now()
FROM jsonb_array_elements({{ JSON.stringify(payload) }}::jsonb) AS elem
ON CONFLICT (hunkware_id, date, reason)
DO UPDATE SET
    fixed = EXCLUDED.fixed,
    notes = EXCLUDED.notes,
    updated_at = EXCLUDED.updated_at;