UPDATE square_data
SET square = v.square, edited = true
FROM unnest({{ update_square_indexes.value }}::int[], {{ update_square_values.value }}::numeric[]) AS v(id, square)
WHERE square_data.id = v.id AND v.square IS NOT NULL