-- Task 1
select name, birthdate 
from moviestar
where name not like '%Jr.%' and name in (select starname 
										 from starsin
										 join movie on movie.title = starsin.movietitle
										 where incolor = 'Y')
order by birthdate desc, name;

-- Task 2
select name, extract(year from birthdate) as birthyear, count(distinct studioname)
from moviestar
left join starsin on moviestar.name = starsin.starname
left join movie on movie.title = starsin.movietitle
where gender = 'F'
group by name
having count(*) <= 6;
-- year(birthdate)
