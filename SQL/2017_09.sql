-- Task 1
SELECT name, country
FROM ships left join outcomes ON name=ship
join classes ON ships.class=classes.class
WHERE result != 'sunk' or result is null;

-- Task 2
SELECT name, displacement, numguns
FROM classes c JOIN ships s ON s.class=c.class
WHERE displacement = (SELECT min(displacement)
						FROM classes) AND
numguns = (SELECT max(numguns)
FROM classes c1
WHERE c.displacement = c1.displacement);

-- Task 3
SELECT battle
FROM outcomes o1
WHERE not exists (SELECT *
FROM outcomes o2
WHERE o1.battle = o2.battle and o1.ship != o2.ship);

-- Task 4
select class, count(distinct name)
from ships
join outcomes on outcomes.ship = ships.name
where result = 'sunk' and class in (select class
									from ships
									group by class
									having count(name) > 5)
group by class;

