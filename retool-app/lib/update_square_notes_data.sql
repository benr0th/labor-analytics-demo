UPDATE square_data
SET notes = v.notes
FROM unnest({{ update_square_indexes.value }}::int[], {{ update_square_notes.value }}::text[]) AS v(id, notes)
WHERE square_data.id = v.id AND v.notes IS NOT NULL