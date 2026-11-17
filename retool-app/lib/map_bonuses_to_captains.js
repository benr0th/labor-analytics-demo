// Map bonus/adj bonus amounts to Captain
return {{ _.zipObject(tips_junk_commissions.data.map(row => row.captain), _.zipWith(tips_bonus_transformer.value, tips_bonus_transformer.value.map(i => 
  _.sum(tips_bonus_transformer.value) >= tips_adj_bonus_threshold.value 
    ? (tips_adj_bonus_threshold.value / _.sum(tips_bonus_transformer.value)) * i 
    : null
), (b, adj) => ({ bonus: b, adj_bonus: adj }))) }}