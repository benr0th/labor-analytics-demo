const startStr = moment.utc(date_range_start.value).format("YYYY-MM-DD");
const endStr   = moment.utc(date_range_end.value).format("YYYY-MM-DD");
const data = hunkware_rev.data
  .filter(r => r["Job Date"] >= startStr && r["Job Date"] <= endStr)
  .sort((a, b) => a["Job Date"].localeCompare(b["Job Date"]));
return _.sumBy(data, r => _.toNumber(r.grand_total_numeric) || 0)