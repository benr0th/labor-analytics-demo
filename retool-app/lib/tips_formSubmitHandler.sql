INSERT INTO tips_and_commissions (
  date,
  name,
  tip,
  commission,
  deductions,
  deduction_reason,
  out_of_state_pay
)
VALUES (
  {{ moment(form_date.value).format('YYYY-MM-DD') }},
  {{ form_name.value }},
  {{ form_tip.value }},
  {{ form_commission.value }},
  {{ form_deductions.value }},
  {{ form_deduction_reason.value }},
  {{ form_out_of_state.value }}
)
ON CONFLICT (date, name) DO UPDATE SET
  tip              = COALESCE(EXCLUDED.tip,              tips_and_commissions.tip),
  commission       = COALESCE(EXCLUDED.commission,       tips_and_commissions.commission),
  deductions       = COALESCE(EXCLUDED.deductions,       tips_and_commissions.deductions),
  deduction_reason = COALESCE(EXCLUDED.deduction_reason, tips_and_commissions.deduction_reason),
  out_of_state_pay = COALESCE(EXCLUDED.out_of_state_pay, tips_and_commissions.out_of_state_pay);