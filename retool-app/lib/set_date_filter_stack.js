if (custom_date) {
  table.setFilterStack({filters: [{"columnId": 'date', "operator": '>=', value: custom_date_range.value.start}, {"columnId": 'date', "operator": '<=', "value": custom_date_range.value.end}]})
} else {
  table.setFilterStack({filters: [{"columnId": `${column}`, "operator": '>=', value:  
`${new Date(select_pay_period.value.split("-")[0]).toLocaleDateString().split("/")[2]}-${new Date(select_pay_period.value.split("-")[0]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(select_pay_period.value.split("-")[0]).toLocaleDateString().split("/")[1].padStart(2,0)}` }, {"columnId": `${column}`, "operator": '<=', "value": `${new Date(select_pay_period.value.split("-")[1]).toLocaleDateString().split("/")[2]}-${new Date(select_pay_period.value.split("-")[1]).toLocaleDateString().split("/")[0].padStart(2,0)}-${new Date(select_pay_period.value.split("-")[1]).toLocaleDateString().split("/")[1].padStart(2,0)}`}]})
}
