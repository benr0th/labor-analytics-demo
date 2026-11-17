function setFilter(table) {
  table.setFilterStack({filters: [{"columnId": 'date', "operator": '>=', value:
`${new Date(tips_select_pay_period.value.split("-")[0]).toLocaleDateString().split("/")[2]}-${new Date(tips_select_pay_period.value.split("-")[0]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(tips_select_pay_period.value.split("-")[0]).toLocaleDateString().split("/")[1].padStart(2,0)}` }, {"columnId": 'date', "operator": '<=', "value": `${new Date(tips_select_pay_period.value.split("-")[1]).toLocaleDateString().split("/")[2]}-${new Date(tips_select_pay_period.value.split("-")[1]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(tips_select_pay_period.value.split("-")[1]).toLocaleDateString().split("/")[1].padStart(2,0)}`}]})
}

setFilter(tips_commissions_table)
square_table.setFilterStack({filters: [
  {
    "columnId": "date",
    "operator": ">=",
    "value": moment.utc(tips_select_pay_period.value.split("-")[0], "M/D/YYYY").startOf('day').format("YYYY-MM-DD")
  },
  {
    "columnId": "date",
    "operator": "<=",
    "value": moment.utc(tips_select_pay_period.value.split("-")[1], "M/D/YYYY").add(1, 'day').format("YYYY-MM-DD")
  }
]})

