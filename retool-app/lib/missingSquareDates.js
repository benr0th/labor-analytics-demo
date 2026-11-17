const requested = ({{ square_dates.value }} ?? []).
map((r) => moment.utc(r.date, ['MMM D, YYYY', moment.ISO_8601], true)).
filter((m) => m.isValid()).
map((m) => m.format('YYYY-MM-DD'));

// getSquareDataMaxDate.data.max_date is a columnar array
const lastDateRaw = {{ getSquareDataMaxDate.data?.max_date }}?.[0] ?? null;
const lastDate = lastDateRaw ? moment.utc(lastDateRaw).format('YYYY-MM-DD') : null;

// getSquareDataDates is also columnar { date: [...] }
const existingDates = new Set(({{ getSquareDataDates.data?.date }} ?? []).
filter(Boolean).
map((d) => moment.utc(d).format('YYYY-MM-DD')));

const missing = requested.
filter((d) => !existingDates.has(d)).
sort();

// Only allow appending up to (lastDate + 1 day) to ensure no gaps.
// Only allow appending consecutive dates starting from (lastDate + 1 day) to ensure no gaps.
const eligible = [];
let cursor = lastDate;
for (const d of missing) {
  if (!cursor) {
    eligible.push(d);
    cursor = d;
    continue;
  }
  const diff = moment.utc(d).diff(moment.utc(cursor), 'days');
  if (diff === 1) {
    eligible.push(d);
    cursor = d;
  } else if (diff <= 0) {
    // duplicate or earlier than cursor — skip
    continue;
  } else {
    // gap detected — stop to prevent holes
    break;
  }
}

return {
  lastDate,
  requestedCount: requested.length,
  existingCount: existingDates.size,
  missing,
  eligible,
  shouldInsert: eligible.length > 0 };