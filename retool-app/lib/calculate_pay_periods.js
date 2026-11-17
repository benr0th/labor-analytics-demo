const anchor = (date => {
  const base = new Date(2025, 11, 20);
  const daysDiff = Math.floor((date - base) / 864e5);
  return new Date(base.getTime() + (Math.floor(daysDiff / 14) + 1) * 14 * 864e5);
})(new Date());

const startDate = new Date(2025, 11, 20);
const periodsBack = Math.floor((anchor - startDate) / (14 * 864e5));

const ranges = Array.from({ length: periodsBack + 1 }, (_, i) => [
  new Date(anchor - (i * 14 + 13) * 864e5),
  new Date(anchor - i * 14 * 864e5),
]);

let date_ranges = [];

const fmt = d => `${d.getMonth()+1}/${d.getDate()}/${d.getFullYear()}`;

for (const range of ranges) {
  date_ranges.push(`${fmt(range[0])}-${fmt(range[1])}`)
}

return date_ranges;
