select
  sum(junk_labor) as junk_labor,
  sum(junk_revenue) as junk_revenue,
  sum(junk_jobs) as junk_jobs,
  case when sum(junk_revenue) > 0 then sum(junk_labor) / sum(junk_revenue) else null end as junk_labor_pct,
  case when sum(junk_jobs) > 0 then sum(junk_revenue) / sum(junk_jobs) else null end as junk_ajs,
  captain
from totals_by_captain_by_day
where captain is not null and junk_jobs > 0 and date between {{tips_date_start.value}} and {{ tips_date_end.value }}
group by captain
ORDER BY split_part(captain, ' ', -1);