-- Task 1
select name, min(year), max(year), count(*)
from studio
left join movie on movie.studioname = studio.name
where studio.name like 'M%'
group by studio.name;

-- Task 2
select name
from (select name, count(*) as filmCnt
		from moviestar
		join starsin on name = starname
		where gender = 'F'
		group by name) craftedTable
where filmCnt >= all (select filmCnt
					 from (select name, count(*) as filmCnt
							from moviestar
							join starsin on name = starname
							where gender = 'F'
							group by name
							order by filmCnt desc));
		
select name, count(*) as filmCnt
from moviestar
join starsin on name = starname
where gender = 'F'
group by name
order by filmCnt desc;
