const ranges = {{ get_pay_periods_in_captGraph_daterange.value }};
return ranges.map(r => {
  const [start, end] = r.split('-').map(d => {
    const [m, day, y] = d.trim().split('/');
    return `${y}-${m.padStart(2,'0')}-${day.padStart(2,'0')}`;
  });
  return `('${start}'::date, '${end}'::date, '${r}')`;
}).join(',\n');