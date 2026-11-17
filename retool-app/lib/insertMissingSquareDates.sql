insert into square_data (date)
select d::date
from unnest({{ missingSquareDates.value.eligible }}::date[]) as d
order by d asc
returning date
