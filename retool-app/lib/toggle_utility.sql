UPDATE table_settings
SET value = to_jsonb({{ toggle_state }}::boolean)
WHERE key = 'include_utility';