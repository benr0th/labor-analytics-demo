const pay_periods = {{ select_pay_period.data }};
const chunked_pay_periods = pay_periods.filter(p => moment(p.split("-")[0]).isSameOrAfter(moment("2026-01-01")) && moment(p.split("-")[1]).isSameOrBefore(moment.now()));
return chunked_pay_periods;