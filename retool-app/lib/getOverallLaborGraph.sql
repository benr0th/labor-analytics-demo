SELECT * FROM get_total_labor_pct_by_period(
  {{ get_pay_periods_in_OverallGraph_daterange.value.join(',') }},
  {{ include_out_of_state.value }},
  {{ include_commissions.value }},
  {{ include_utility.value }}
);