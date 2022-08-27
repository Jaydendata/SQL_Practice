-- comment
/* Multiline Comment 
*/

-- Orders Dataset

SELECT COALESCE (ship_mode,'total'), COALESCE (postal_code,'total'), ROUND(AVG(sales),2) AS average_sales
From orders
WHERE profit > 0.4
GROUP BY ROLLUP (ship_mode, postal_code)
---ORDER BY postal_code
ORDER BY postal_code


--- 1. How many countries does each salesperson operate in?
SELECT COUNT(DISTINCT country_code) AS Country_number,salesperson
FROM regions
GROUP BY salesperson
ORDER BY Country_number desc



--- 2. How many items were returned for each return reason?
SELECT SUM(return_quantity) AS Quantity,reason_returned, COUNT(return_quantity) AS Rows
FROM returns
GROUP BY reason_returned
ORDER BY 2 desc;



--- 3. What is the average cost of products in each sub category, excluding items in the furniture category?
SELECT AVG(product_cost_to_consumer)Average_costs,sub_category,category
FROM products
WHERE category != 'Furniture'
GROUP BY sub_category,category
ORDER BY Average_costs desc


--- 4. What is the average cost of products by sub-category, rounded to two decimal places?
SELECT ROUND(AVG(product_cost_to_consumer),2)AS Average_costs,sub_category
FROM products
GROUP BY sub_category
ORDER BY Average_costs desc



--- 5. Exclude any sub_categories from the list where the average price is $100 or more
SELECT ROUND(AVG(product_cost_to_consumer),2)AS Average_costs,sub_category
FROM products
GROUP BY sub_category
HAVING ROUND(AVG(product_cost_to_consumer),2) < 100
ORDER BY Average_costs desc


/* 6. Produce a table of data that shows total revenue per individual product (use product_id), 
showing only those products that meet a minium threshold of $10000 in sales, order the list high to low.*/

SELECT product_id, SUM(sales) AS Revenue
FROM orders
GROUP BY product_id
HAVING SUM(sales) >= 10000
ORDER BY Revenue desc
---4713



/* 7. How many product IDs met this minimum threshold of sales?*/
---same as above, grouped by is already distinct
SELECT COUNT(product_id) AS number_met_threshold
		FROM (SELECT product_id, sum(sales)
			  FROM orders
			  GROUP BY product_id
			  HAVING SUM(sales) >= 10000) AS temp



/* 8. How many product IDs were sold in total (irrespective of the threshold)?*/
SELECT COUNT(DISTINCT product_id)AS product_id_number
FROM orders
---10292



/* 9.What share (%) of produdcts meet the minimum threshold of $10000?*/

SELECT ROUND((4713/10292 :: numeric)*100,2)

-- OR Subquery

SELECT
(SELECT COUNT(product_id) AS number_met_threshold
		FROM (SELECT product_id, sum(sales)::money
			  FROM orders
			  GROUP BY product_id
			  HAVING SUM(sales) >= 10000) AS temp)
/
(SELECT COUNT(DISTINCT product_id)FROM orders) ::numeric

-- Or

SELECT ROUND((100*(COUNT(*)::NUMERIC)/
              (SELECT COUNT(DISTINCT product_id) FROM orders)::NUMERIC), 2)||'%' AS percentage_met_threshold
FROM (SELECT COUNT(DISTINCT product_id)
      FROM orders
      GROUP BY product_id
      HAVING SUM(sales) >= 10000) AS temp