--- Superstore Datatset

------------------------------------------3--------------------------------------
/*You notice the Executive Impressions wall clock names are really long. For these products,
omit the words “Executive Impressions” from the place card. Write a query that returns the
same verbiage as in #1 but without the vendor name for only Executive Impressions wall
clocks. How many characters is it now and do they meet the 100 character limit? */


--replace words

SELECT DISTINCT CONCAT (
                        'In the '
                        ,sub_category
                        ,' department, the '
                        ,REPLACE(product_name,'Executive Impressions','')   
                        ,' is on sale for 50% off!'
                          )AS Con_name
                ,LENGTH(
                        CONCAT (
                                'In the '
                                ,sub_category
                                ,' department, the '
                                ,REPLACE(product_name,'Executive Impressions','')
                                ,' is on sale for 50% off!'
                                )
                        )AS length_name
FROM public.products
WHERE product_name ILIKE'%Executive Impression%' AND product_name ILIKE'%wall clock%'
ORDER BY 2 DESC


----- OR: Reverse extract

SELECT DISTINCT CONCAT (
                        'In the '
                        ,sub_category
                        ,' department, the '
                        ,SUBSTRING(product_name,LENGTH('Executive Impressions')+1)   
                        ,' is on sale for 50% off!'
                          )AS Con_name
       ,LENGTH(
                CONCAT (
                        'In the '
                        ,sub_category
                        ,' department, the '
                        ,SUBSTRING(product_name,LENGTH('Executive Impressions')+1)   
                        ,' is on sale for 50% off!'
                          )
               )AS Name_length                        
FROM public.products
WHERE product_name ILIKE'%Executive Impressions%' AND product_name ILIKE'%wall clock%' 
ORDER BY 2 Desc




-------------4---------------
/* Looking at the customer roster, create a column that only shows the customer’s last name.
Ensure there are no extra white spaces. Hint: Use SUBSTRING, STRPOS, and TRIM.*/



-- extract names include empty spaces

SELECT TRIM(SUBSTRING(customer_name,STRPOS(customer_name,' ')))AS last_name
FROM public.customers
ORDER BY BTRIM(SUBSTRING(customer_name,STRPOS(customer_name,' ')))
LIMIT 100




---------------5----------------

/* 5. Your team wants to issue a market research survey to a sample pool of customers. Using
the LEFT function, find the customers and their segments who fall into the AD, AF, or AJ
group. */



SELECT LEFT(UPPER(customer_name),2)
FROM public.customers       
WHERE LEFT(UPPER(customer_name),2) IN ('AD','AF','AJ')
                              



----------------------6-----------------
/* 6. Split the order_id into 3 separate columns. Limit results to 100 rows.
"AE-2016-1308551"
*/


SELECT SUBSTRING(order_id,1,2) AS column_one
       ,SUBSTRING(order_id,4,4) AS column_two
       ,SUBSTRING(order_id,9) AS column_three
FROM public.orders
LIMIT 100


SELECT SUBSTRING(order_id,4,4) AS column_two
FROM public.orders
LIMIT 100



SELECT order_id
FROM public.orders
LIMIT 100




------------------7-------------------
/* 7. Superstore is updating its shipping categories and needs to refresh this in our database. In
the orders table, change “Standard Class” to “Economy Class” and show how many orders
were placed in 2018 for each of the ship mode classes. */



SELECT order_id
       ,CASE
        WHEN ship_mode = 'Standard Class'
        THEN 'Economy Class'
        ELSE ship_mode
        END AS ship_mode_class
FROM orders
WHERE DATE_PART('YEAR',order_date) = 2018




------------------- 8 --------------------
/* By day, how many orders were there between Thanksgiving 2019 (November 28,
2019) and New Year’s Day 2020 (January 1, 2020)? */


SELECT COUNT (DISTINCT order_id)
FROM public.orders
WHERE order_date BETWEEN '2019-11-28' AND '2020-01-01'





-------------------9-----------------------
/* For each ship mode, what is the highest # of days it takes to ship a product after it
has been ordered for products priced higher than $1,000? */


SELECT REPLACE (ship_mode,'Standard Class','Economic Class')
       ,max(ship_date - order_date) AS max_days
FROM public.orders
WHERE sales > 1000
GROUP BY ship_mode 
ORDER BY 2


---- or:


SELECT REPLACE (ship_mode,'Standard Class','Economic Class')as ship_mode
       ,max(AGE(ship_date,order_date)) AS max_days
FROM public.orders
WHERE sales > 1000
GROUP BY 1
ORDER BY 2



--------------------10-------------------
/* Using CASE WHEN logic, sum up sales, quantity, and profit by each calendar quarter
of 2018. Hint: Dates are in YYYY-MM-DD format and you can use BETWEEN. */


SELECT 
    CASE 
      WHEN order_date BETWEEN '2018-01-01' AND '2018-03-31' THEN 'Q1_2018' 
      WHEN order_date BETWEEN '2018-04-01' AND '2018-06-30' THEN 'Q2_2018' 
      WHEN order_date BETWEEN '2018-07-01' AND '2018-09-30' THEN 'Q3_2018' 
      WHEN order_date BETWEEN '2018-10-01' AND '2018-12-31' THEN 'Q4_2018'     
    END as quarter
    
    ,SUM(sales) as sales
    ,SUM(quantity) as qty
    ,SUM(profit) as profit

FROM orders
WHERE DATE_PART('year', order_date) = 2018
GROUP BY 1 
ORDER BY 1;




--------------------11-------------------
/* Complete #10 again using the DATE_TRUNC or DATE_PART functions instead of CASE WHEN.*/

SELECT DATE_PART('QUARTER',order_date) AS quart
        ,SUM(sales) as sales
        ,SUM(quantity) as quantity
        ,SUM(profit) as profit
FROM orders
WHERE DATE_PART('YEAR',order_date)=2018
GROUP BY 1
ORDER BY 1
