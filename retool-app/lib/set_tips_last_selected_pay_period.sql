UPDATE table_settings
SET "value" = to_jsonb({{ tips_select_pay_period.value }}::text)
WHERE "key" = 'tips_last_selected_pay_period';