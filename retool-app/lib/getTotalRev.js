const isMoving = job_type1 === "Moving";

function filterDateRange(start_date, end_date) {
  return hunkware_rev.data.filter(r => {
    const rowDate = moment.utc(r["Job Date"]).startOf("day").toDate();
    const dest = r["Destination State/Prov"];

    const stateFilter = !isMoving || (
      include_out_of_state.value
        ? (dest === 'FL' || dest !== 'FL' || dest === '' || dest == null)   // out-of-state: non-FL, FL, or blank
        : (dest === 'FL' || dest === '' || dest == null)   // in-state: FL or blank
    );

    return rowDate >= start_date && rowDate <= end_date &&
      (r.Category === job_type1 || r.Category === job_type2) &&
      ["Closed", "Completed"].includes(r.Status) &&
      stateFilter;
  });
}

function sumRevenue(data) {
  return _.sumBy(data, r => _.toNumber(r.grand_total_numeric));
}

function getDayDiff() {
  if (use_custom_date_range.value) {
    return Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'), 'days', true));
  }
  return Math.ceil(moment(select_pay_period.value.split("-")[1]).endOf('day').diff(moment(select_pay_period.value.split("-")[0]).startOf('day'), 'days', true));
}

function toStartOfDay(val) {
  return moment.utc(val).startOf('day').toDate();
}

function toEndOfDay(val) {
  return moment.utc(val).endOf('day').toDate();
}

const dayDiff = getDayDiff();

const start = toStartOfDay(date_range_start.value);
const end = toEndOfDay(date_range_end.value);
const prev_start = toStartOfDay(moment.utc(date_range_start.value).subtract(dayDiff, 'days'));
const prev_end = toEndOfDay(moment.utc(date_range_end.value).subtract(dayDiff, 'days'));

// Current period
const rev = sumRevenue(filterDateRange(start, end));
(isMoving ? totalMoveRev : totalJunkRev).setValue(rev);

// Previous period
const prevRev = sumRevenue(filterDateRange(prev_start, prev_end));
(isMoving ? totalMoveRevPrevPP : totalJunkRevPrevPP).setValue(prevRev);