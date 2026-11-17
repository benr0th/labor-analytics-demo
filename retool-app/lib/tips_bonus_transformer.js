// Creates the Junk Commissions Bonus column for use with the Adjusted Bonus column
let bonuses = [];

{{ tips_junk_commissions.data }}.forEach(row => bonuses.push(row.junk_labor_pct < {{ tips_bonus_goal.value }} ? ({{ tips_bonus_goal.value }} - row.junk_labor_pct)*row.junk_revenue : null))

return bonuses;