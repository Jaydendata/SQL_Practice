-- SUPER Store data (Postgres)

--- JOIN

SELECT SUM(r.return_quantity) total_returns, customer_id
FROM orders o
  	JOIN returns r 
	ON o.order_id = r.order_id
GROUP BY o.customer_id
HAVING SUM(r.return_quantity) > 200
ORDER BY total_returns desc
LIMIT 10





SELECT c.customer_name,o.order_id,r.reason_returned
FROM orders AS o
	INNER JOIN customers AS c
	ON o.customer_id = c.customer_id 
	LEFT JOIN returns AS r
	ON o.order_id = r.order_id
ORDER BY c.customer_name asc
LIMIT 1000



SELECT COUNT(o.order_id), c.customer_name, SUM(r.return_quantity), r.reason_returned
FROM orders AS o
	JOIN customers AS c
	ON o.customer_id = c.customer_id 
	JOIN returns AS r
	ON o.order_id = r.order_id
GROUP BY c.customer_name, r.reason_returned
HAVING SUM(r.return_quantity) > 100
ORDER BY SUM(r.return_quantity) DESC
LIMIT 100


SELECT o.order_id, r.return_date
FROM orders o
	LEFT JOIN returns r 
	ON o.order_id = r.order_id
LIMIT 100


SELECT o.order_id, o.order_date, o.ship_date, ret.reason_returned, reg.country, reg.region, reg.salesperson
FROM orders o
	INNER JOIN regions reg
	ON o.region_id = reg.region_id
	LEFT JOIN returns ret
	ON o.order_id = ret.order_id
ORDER BY reg.salesperson
LIMIT 100


SELECT COUNT(o.order_id) AS returns_number, reg.salesperson, SUM(r.return_quantity) AS returned_quantity, r.reason_returned
FROM orders AS o
	JOIN regions AS reg
	ON o.region_id = reg.region_id 
	JOIN returns AS r
	ON o.order_id = r.order_id
GROUP BY reg.salesperson, r.reason_returned
HAVING SUM(r.return_quantity) > 100
ORDER BY SUM(r.return_quantity) DESC
LIMIT 100


--- UNION



SELECT COUNT(o.order_id)AS Number_of_sales, r.salesperson
FROM orders AS o
	JOIN regions AS r
	ON o.region_id = r.region_id
	LEFT JOIN returns AS ret 
	ON o.order_id = ret.order_id
WHERE o.sales IS NOT NULL AND (r.salesperson IS NOT NULL AND (ret.return_quantity IS NULL))
GROUP BY r.salesperson
ORDER BY Number_of_sales desc


SELECT *
FROM orders AS o
	JOIN regions AS r
	ON o.region_id = r.region_id
	LEFT JOIN returns AS ret 
	ON o.order_id = ret.order_id
WHERE ret.return_quantity IS NULL


SELECT *
FROM orders AS o
	JOIN regions AS r
	ON o.region_id = r.region_id
	RIGHT JOIN returns AS ret 
	ON o.order_id = ret.order_id
WHERE o.order_id IS NULL


