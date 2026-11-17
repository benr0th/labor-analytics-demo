const isMove = in_labor_type === "Move";

function filterLabor(start, end) {
  return labor_data.data.filter(l => {
    const rowDate = moment.utc(l.date).toDate();
    const matchesType = l.laborType === in_labor_type || (include_utility.value && !isMove && l.laborType == "Utility");
    return rowDate >= start && rowDate <= end && matchesType;
  });
}

function sumLabor(data) {
  return _.sumBy(data, r => _.toNumber(r.labor));
}

function getDayDiff() {
  if (use_custom_date_range.value) {
    return Math.ceil(moment(custom_date_range.value.end).endOf('day').diff(moment(custom_date_range.value.start).startOf('day'),'days',true))
  } else {
      return Math.ceil(moment(select_pay_period.value.split("-")[1]).endOf('day').diff(moment(select_pay_period.value.split("-")[0]).startOf('day'),'days',true))
  }
  return 14;
}

function toStartOfDay(val) {
  return moment.utc(new Date(val)).startOf('day').toDate()
}

function toEndOfDay(val) {
  return moment.utc(new Date(val)).endOf('day').toDate()
}

async function getOOS(start, end) {
  if (include_out_of_state.value && isMove) {
      const query = await getOutofStateLabor.trigger({additionalScope: {date_start: start, date_end: end}})
  return _.toNumber(query.sum[0])
  } else {
    return 0;
  }
}

async function getMoveComms(start, end) {
  if (include_commissions.value && isMove) {
        const query = await getMoveCommissions.trigger({additionalScope: {date_start: start, date_end: end}})
  return _.toNumber(query.sum[0])
  } else {
    return 0;
  }
}

async function getJunkComms(start, end) {
  if (include_commissions.value && !isMove) {
    const query = await getJunkCommissionsPrevPP.trigger({ additionalScope: { date_start: start, date_end: end } });
    return _.sumBy(query.adjusted_bonus, _.toNumber);
  } else {
    return 0;
  }
}

const start = toStartOfDay(date_range_start.value)
const end = toEndOfDay(date_range_end.value)
const prev_start = toStartOfDay(moment.utc(date_range_start.value).subtract(getDayDiff(), 'days'))
const prev_end = toEndOfDay(moment.utc(date_range_end.value).subtract(getDayDiff(), 'days'))

const [out_of_state, prev_out_of_state, move_commissions, prev_move_commissions, junk_commissions, prev_junk_commissions] = await Promise.all([
  getOOS(start,end),
  getOOS(prev_start,prev_end),
  getMoveComms(start, end),
  getMoveComms(prev_start, prev_end),
  getJunkComms(start, end),
  getJunkComms(prev_start, prev_end)
])
//  const out_of_state = await getOOS(start,end)
//  const prev_out_of_state = await getOOS(prev_start,prev_end)
//  const move_commissions = await getMoveComms(start, end)
//  const prev_move_commissions = await getMoveComms(prev_start, prev_end)

// Current period
const labor = sumLabor(filterLabor(start, end)) + out_of_state + move_commissions + junk_commissions;
(isMove ? totalMoveLabor : totalJunkLabor).setValue(labor);

// Previous period
const prevLabor = sumLabor(filterLabor(prev_start, prev_end)) + prev_out_of_state + prev_move_commissions + prev_junk_commissions;
(isMove ? totalMoveLaborPrevPP : totalJunkLaborPrevPP).setValue(prevLabor);