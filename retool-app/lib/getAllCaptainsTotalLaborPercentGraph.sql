SELECT * FROM get_all_captain_total_labor_pct(
  {{ get_all_pay_periods.value.join(',') }},
  {{ include_out_of_state.value }},
  {{ include_commissions.value }},
  {{ include_utility.value }},
  {{ all_time_labor_show_move.value }},
  {{ all_time_labor_show_junk.value }}
);