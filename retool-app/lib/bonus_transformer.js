// Creates the Junk Commissions Bonus column for use with the Adjusted Bonus column
let bonuses = [];

{{ junk_commissions.data }}.forEach(row => bonuses.push(row.junk_labor_pct < {{ bonus_goal.value }} ? ({{ bonus_goal.value }} - row.junk_labor_pct)*row.junk_revenue : null))

return bonuses;