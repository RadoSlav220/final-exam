select starname
from starsin
join moviestar on starname = name
where gender = 'F' and name in (select starname
								from starsin
								where movieyear <= 2000
							  intersect
								select starname
								from starsin
								where movieyear > 2000);
