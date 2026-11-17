// Map bonus/adj bonus amounts to Captain
return {{ _.zipObject(junk_commissions.data.map(row => row.captain), _.zipWith(bonus_transformer.value, bonus_transformer.value.map(i => 
  _.sum(bonus_transformer.value) >= adj_bonus_threshold.value 
    ? (adj_bonus_threshold.value / _.sum(bonus_transformer.value)) * i 
    : null
), (b, adj) => ({ bonus: b, adj_bonus: adj }))) }}