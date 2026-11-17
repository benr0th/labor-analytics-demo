const pay_periods = {{ select_pay_period.data }};
const chunked_pay_periods = pay_periods.filter(p => moment(p.split("-")[0]).isSameOrAfter(moment({{ captain_graph_date_range.value.start }})) && moment(p.split("-")[1]).isSameOrBefore(moment({{ captain_graph_date_range.value.end }})));
return chunked_pay_periods;