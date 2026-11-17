UPDATE table_settings
SET "value" = {{ custom_date_range.value }}
WHERE "key" = 'last_selected_date_range';