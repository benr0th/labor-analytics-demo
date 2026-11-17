let changes = unmatched_hunkware_ids_table.changesetObject;
let rows = unmatched_hunkware_ids_table.data;
let payload = Object.entries(changes).map(([rowId, change]) => {
  let row = rows.find(r => String(r._rowId) === String(rowId));
  if (!row) return null;
  return {
    hunkware_id: row.hunkware_id,
    date: row.date,
    shift_team: row.shift_team,
    labor_type: row.laborType,
    reason: row.reason,
    fixed: change.fixed ?? row.fixed,
    notes: change.notes ?? row.notes
  };
}).filter(Boolean);

return payload;