select sum(out_of_state_pay) from tips_and_commissions
where date between {{ date_start }} and {{ date_end }}
