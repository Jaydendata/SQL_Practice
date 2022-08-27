-- Subquery

SELECT location
FROM covid
WHERE total_cases > (
		SELECT MAX(total_cases)
		FROM covid
		WHERE continent = 'Africa'
		);
       
       
SELECT (
        SELECT MAX(reproduction_rate)
        FROM covid
        WHERE continent = 'Europe'
       ) > ALL (
                SELECT reproduction_rate
                FROM covid
                WHERE continent = 'Asia'
                );




WITH CTE_testing 
AS (
    SELECT AVG(price)
    FROM shoes
    )  
SELECT price
FROM Shoes
WHERE price > (
                SELECT * 
                FROM CTE_testing
               );