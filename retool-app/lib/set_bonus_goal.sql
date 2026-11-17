UPDATE table_settings
SET "value" = to_jsonb({{ bonus_goal.value }}::numeric)
WHERE "key" = 'bonus_goal';