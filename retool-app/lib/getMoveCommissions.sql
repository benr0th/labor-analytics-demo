select sum(commission) from tips_and_commissions
where date between {{ date_start }} and {{ date_end }}
