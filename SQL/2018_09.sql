-- Task 1
select classes.class, min(battles.date), max(battles.date), count(battles.name) 
from classes
left join ships on ships.class = classes.class
left join outcomes on outcomes.ship = ships.name
left join battles on battles.name = outcomes.battle
where classes.class like 'N%'
group by classes.class;

-- Task 2
select name
from battles b
where (select count(*)
		from outcomes
		join ships on outcomes.ship = ships.name
		join classes on classes.class = ships.class
		where type = 'bb'and outcomes.battle = b.name
		group by battle) > (select count(*)
							from outcomes
							join ships on outcomes.ship = ships.name
							join classes on classes.class = ships.class
							where type = 'bc'and outcomes.battle = b.name
							group by battle)
