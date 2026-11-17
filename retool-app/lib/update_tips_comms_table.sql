UPDATE tips_and_commissions
SET
  tip = COALESCE(v.tip, tips_and_commissions.tip),
  commission = COALESCE(v.commission, tips_and_commissions.commission),
  deductions = COALESCE(v.deductions, tips_and_commissions.deductions),
  deduction_reason = COALESCE(v.deduction_reason, tips_and_commissions.deduction_reason),
  out_of_state_pay = COALESCE(v.out_of_state_pay, tips_and_commissions.out_of_state_pay)
FROM unnest(
  {{ update_tips_table_transformer.value.ids }}::int[],
  {{ update_tips_table_transformer.value.tip }}::numeric[],
  {{ update_tips_table_transformer.value.commission }}::numeric[],
  {{ update_tips_table_transformer.value.deductions }}::numeric[],
  {{ update_tips_table_transformer.value.deduction_reason }}::text[],
  {{ update_tips_table_transformer.value.out_of_state_pay }}::numeric[]
) AS v(id, tip, commission, deductions, deduction_reason, out_of_state_pay)
WHERE tips_and_commissions.id = v.id
  AND (v.tip IS NOT NULL OR v.commission IS NOT NULL
       OR v.deductions IS NOT NULL OR v.deduction_reason IS NOT NULL
       OR v.out_of_state_pay IS NOT NULL);