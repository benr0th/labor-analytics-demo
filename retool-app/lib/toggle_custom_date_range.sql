UPDATE table_settings
SET value = to_jsonb({{ toggle_state }}::boolean)
WHERE key = 'use_custom_date_range';