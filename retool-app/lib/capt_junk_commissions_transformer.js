// Creates the Junk Commissions Bonus column for use with the Adjusted Bonus column
let comms = [];

{{ totals_by_captain.data }}.forEach(row => comms.push({{ junk_commissions.data }}.find(r => r.captain === row.captain)?.adjusted_bonus))

return comms;