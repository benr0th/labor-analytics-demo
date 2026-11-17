return {
  ids:              {{ _.map(Object.keys(tips_commissions_table.changesetObject), id => Number(id)) }},
  tip:              {{ _.map(Object.values(tips_commissions_table.changesetObject), v => v.tip ?? null) }},
  commission:       {{ _.map(Object.values(tips_commissions_table.changesetObject), v => v.commission ?? null) }},
  deductions:       {{ _.map(Object.values(tips_commissions_table.changesetObject), v => v.deductions ?? null) }},
  deduction_reason: {{ _.map(Object.values(tips_commissions_table.changesetObject), v => v.deduction_reason ?? null) }},
  out_of_state_pay: {{ _.map(Object.values(tips_commissions_table.changesetObject), v => v.out_of_state_pay ?? null) }},
};