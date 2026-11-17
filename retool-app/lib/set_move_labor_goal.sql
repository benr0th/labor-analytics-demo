UPDATE table_settings
SET "value" = to_jsonb({{ move_labor_goal.value }}::numeric)
WHERE "key" = 'move_labor_goal';