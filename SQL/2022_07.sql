select s.name, m.title
from movie m join studio s on m.studioname = s.name
where s.name = (select studioname 
				 from movie
				 where title = 'The Usual Suspects' and year = 1995);
				 
SELECT ms.name, si.movietitle
FROM moviestar ms
LEFT JOIN starsin si
ON ms.name=si.starname
WHERE si.movietitle IS NULL;