-- Task 1
select name, address
from studio
where name in ((select studioname
				from movie
				where incolor = 'Y')
				intersect
				(select studioname
				from movie
				where incolor = 'N'))
order by address asc;

-- insert into movie (title, year, length, incolor, studioname, producerc_no)
-- values ('Very old one', 1959, 97, 'N', 'MGM', 555)

-- Task 2
select name, address, avg(length)
from studio
left join movie on studio.name = movie.studioname
group by studio.name
having count(*) <= 3;

-- select * from studio;

-- insert into studio (name, address, presc_no)
-- values ('New Empty', '220 Dummy Street', 6)

