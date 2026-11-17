UPDATE table_settings
SET value = to_jsonb({{ toggle_state }}::boolean)
WHERE key = 'include_out_of_state';