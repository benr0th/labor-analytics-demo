// Reference external variables with curly brackets or using JS variables
return moment.utc({{ tips_select_pay_period.value.split("-")[1] }}).endOf('day').toDate();