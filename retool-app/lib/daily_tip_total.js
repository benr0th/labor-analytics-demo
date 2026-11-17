const dtt = [];
const data = {{ tips_commissions_table.data }};

const daily_tip_totals = _.map(
  _.groupBy(data, 'date'),
  (rows, date) => ({
    date,
    tipTotal: _.sumBy(rows, r => parseFloat(r.tip) || 0)
  })
);

{{ square_table.data }}.forEach(row => dtt.push(daily_tip_totals.find(r => moment(r.date).isSame(row.date, 'day'))?.tipTotal))

return dtt;