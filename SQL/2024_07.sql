select *
from pc
left join product on product.model = pc.model
where pc.model is null or pc.model like 'A%2';

SELECT maker
FROM Product p
WHERE type = 'Laptop'
AND EXISTS (SELECT *
FROM Product
WHERE type = 'PC'
AND maker = p.maker)
GROUP BY maker
HAVING COUNT(*) >= 2;

select maker, count(distinct model) 
from product
where type = 'Laptop'
group by maker;

select maker, count(distinct model) 
from product
where type = 'PC'
group by maker;
