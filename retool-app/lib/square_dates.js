if (!{{ tips_select_pay_period.data.at(-1) }}) return;

return ((s) => { const [a, b] = s.split('-').map(d => moment(d, 'M/D/YYYY')); return _.times(b.diff(a, 'days') + 1, i => a.clone().add(i, 'days').format('MMM D, YYYY')); })({{ `${tips_select_pay_period.data.at(-1).split("-")[0]}-${tips_select_pay_period.data.at(0).split("-")[1]}` }}).map(v => ({"date": v}))