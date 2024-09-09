select title, length
from movie
where incolor = 'Y' and length is not null and length != (select max(length)
															from movie
														 	where incolor = 'Y');
