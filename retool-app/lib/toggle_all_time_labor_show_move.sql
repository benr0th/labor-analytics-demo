UPDATE table_settings
SET value = to_jsonb({{ toggle_state }}::boolean)
WHERE key = 'all_time_labor_show_move';