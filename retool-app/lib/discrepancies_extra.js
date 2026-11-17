if ({{!unmatched_hunkware_ids_table.changesetObject}}) return;
let changes = Object.entries({{unmatched_hunkware_ids_table.changesetObject}});

let data = {{unmatched_hunkware_ids_table.data}};

changes.forEach(change => {
  data[change[0]] = _.merge(data[change[0]], change[1]);
})

return data;