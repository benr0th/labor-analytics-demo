UPDATE square_data
SET notes = ''
WHERE id = {{ square_table.selectedDataIndex + 1 }}