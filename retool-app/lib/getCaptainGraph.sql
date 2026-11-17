SELECT * FROM get_captain_labor_pct_by_period(
  {{ totals_by_captain.selectedRow.captain }},
  {{ get_pay_periods_in_captGraph_daterange.value.join(',') }},
  {{ include_out_of_state.value }},
  {{ include_commissions.value }},
  {{ include_utility.value }}
);