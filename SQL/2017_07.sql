-- Task 1
SELECT studioname, title, year
FROM movie m
WHERE year = (SELECT max(year)
FROM movie
WHERE studioname = m.studioname);

-- Task 2
SELECT name, sum(length)
FROM movieexec JOIN movie ON producerc_no = cert_no
where exists (select 1 from movie m where movieexec.cert_no = m.producerc_no and year < 1980)
group by name;

-- Task 3
SELECT starname, title, name, networth
FROM starsin JOIN movie ON movietitle=title AND movieyear=year
JOIN (SELECT cert_no, networth, name
FROM movieexec
WHERE networth = (select max(networth) from movieexec)) t
on movie.producerc_no = t.cert_no;

-- Task 4
select name, title, year
from movie
join movieexec on movieexec.cert_no = movie.producerc_no
where movieexec.cert_no in (select producerc_no 
							  from movie
							  where title = 'Star Wars');
