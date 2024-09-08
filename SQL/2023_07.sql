select class 
from classes
where class not in (select class
					from ships
					join outcomes on ships.name = outcomes.ship
					where result = 'damaged')
