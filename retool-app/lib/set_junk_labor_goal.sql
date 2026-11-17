UPDATE table_settings
SET "value" = to_jsonb({{ junk_labor_goal.value }}::numeric)
WHERE "key" = 'junk_labor_goal';