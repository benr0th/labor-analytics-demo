UPDATE square_data
SET square = 0
WHERE id = {{ square_table.selectedDataIndex + 1 }}