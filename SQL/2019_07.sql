-- Task 1
select studioname, count(*)
from movie
group by studioname
having count(*) < 2;

-- Task 2
select name
from movieexec
where networth = (select min(networth)
					from movieexec);
