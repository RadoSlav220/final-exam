select code, price
from laptop l
where screen >= 13 and screen <=15 and exists (select * from pc p where l.ram = p.ram);

SELECT code, price FROM Laptop
WHERE screen BETWEEN 13 AND 15
AND ram IN (SELECT ram
			FROM PC);

select maker, count(code)
from product
left join laptop on product.model = laptop.model and screen = 15
group by maker;

SELECT maker, COUNT(code) FROM Laptop
RIGHT JOIN Product
ON Laptop.model = Product.model
AND screen = 15
GROUP BY maker;
