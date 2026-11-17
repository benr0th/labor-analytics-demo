const DAY = 864e5;
const base = Date.UTC(2026, 1, 20);
const cap  = Date.UTC(2026, 5, 30);    // upper limit: June 30, 2026

const today = new Date();
const todayUTC = Date.UTC(today.getFullYear(), today.getMonth(), today.getDate());

// next period boundary after today (original behavior)
const nextBoundary = base + (Math.floor((todayUTC - base) / DAY / 14) + 1) * 14 * DAY;
// last period boundary on or before the cap
const lastAllowed = base + Math.floor((cap - base) / DAY / 14) * 14 * DAY;

const anchor = Math.min(nextBoundary, lastAllowed);
const periodsBack = Math.round((anchor - base) / (14 * DAY));

const fmt = ms => {
  const d = new Date(ms);
  return `${d.getUTCMonth() + 1}/${d.getUTCDate()}/${d.getUTCFullYear()}`;
};

const date_ranges = Array.from({ length: periodsBack + 1 }, (_, i) =>
  `${fmt(anchor - (i * 14 + 13) * DAY)}-${fmt(anchor - i * 14 * DAY)}`
);

return date_ranges;

// Original code
/* 
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
*/