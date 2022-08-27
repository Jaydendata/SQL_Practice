--- Text strings and Date & Time



SELECT 
    UPPER(category)AS upper_category
    ,LENGTH (CONCAT(sub_category,product_name)) AS length_new_name
    ,SUBSTRING(REPLACE(product_id, '-', ''), 1, 5) as sub_product_id
FROM public.products
    WHERE LENGTH (CONCAT(sub_category,product_name)) < 100
    ORDER BY 2 desc
    LIMIT 5;



SELECT UPPER(category) as upper_category,
    LENGTH(CONCAT(sub_category, product_name)) AS new_name,
    SUBSTRING(REPLACE(product_id, '-', ''), 1, 5) as sub_product_id
FROM products
    WHERE LENGTH(CONCAT(sub_category, product_name)) < 100
    GROUP BY 1,2,3
    ORDER BY 2 DESC
    LIMIT 5;


SELECT AGE (MIN(order_date),MAX(order_date)) AS range_order,
       AGE (MIN(ship_date),MAX(ship_date)) AS range_shipping
FROM public.orders



SELECT SUM(QUANTITY)
        ,order_date
FROM  public.orders
GROUP BY order_date
Order by 1 desc
LIMIT 10




SELECT
SUM(quantity)
    ,DATE_TRUNC('month', order_date)
FROM orders
GROUP BY 2
ORDER BY 1 DESC;


SELECT
SUM(quantity)
    ,DATE_PART('month', order_date)
FROM orders
GROUP BY 2
ORDER BY 1 DESC;



SELECT *
FROM orders
WHERE order_date >= '2020-01-01'



------------------Q1. Failed trial: only replace X----------------------------------
SELECT 
      REPLACE('In the X department, the Y is on sale for 50% off!','X',sub_category) 
      AS sales_name1
FROM products
ORDER BY LENGTH(
      REPLACE('In the X department, the Y is on sale for 50% off!','X',sub_category)
                )
LIMIT 10




------------------Q1. Join words together with product names--------------------------

SELECT 
	CONCAT(
	'In the '
		,sub_category
		,'the '
		,product_name
		,' is on sale for 50% off!'
	) AS sale_announce
FROM products


-------------------How many have char. >100 ------------------


SELECT 
	DISTINCT CONCAT(
	    'In the '
		,sub_category
		,'the '
		,product_name
		,' is on sale for 50% off!'
	)AS sale_announce_OVER100
FROM products
WHERE LENGTH(CONCAT(
	    'In the '
		,sub_category
		,'the '
		,product_name
		,' is on sale for 50% off!'
	))>100
ORDER BY 1


--------------- Count how many with char.>100 -------------------


SELECT 
	COUNT(DISTINCT CONCAT(
	    'In the '
		,sub_category
		,'the '
		,product_name
		,' is on sale for 50% off!'
	)) AS sale_announce_OVER100
FROM products
WHERE LENGTH(CONCAT(
	    'In the '
		,sub_category
		,'the '
		,product_name
		,' is on sale for 50% off!'
	))>100

---------------------- 



SELECT REPLACE(UPPER(category),' ','') AS UPPER_CATEGORY
       ,LENGTH(CONCAT(sub_category,product_name))AS NEW_NAME
       ,REPLACE(SUBSTRING(REPLACE(product_id,'-',''),1,5),' ','')AS SUB_ID
FROM public.products
WHERE  LENGTH(CONCAT(sub_category,product_name))<100
ORDER BY 2 DESC
LIMIT 5














SELECT CONCAT_ws (', ',customer_id,customer_name)
FROM public.customers
LIMIT 10


SELECT TRIM (BOTH FROM (customer_id || ', ' || customer_name))
FROM public.customers
limit 10


SELECT REGEXP_REPLACE('enterprise 	', '\s+$', '');



SELECT UPPER(SUBSTRING (customer_name FROM 2 FOR 4))
FROM public.customers
LIMIT 10