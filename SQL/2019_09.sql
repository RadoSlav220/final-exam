-- Task 1
select name, year, count(*)
from movieexec
join movie on movie.producerc_no = movieexec.cert_no
group by name, cert_no, year;


-- Task 2
select name
from moviestar
where birthdate = (select max(birthdate)
			 		from moviestar);
