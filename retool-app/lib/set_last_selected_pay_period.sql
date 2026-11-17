UPDATE table_settings
SET "value" = to_jsonb({{ select_pay_period.value }}::text)
WHERE "key" = 'last_selected_pay_period';