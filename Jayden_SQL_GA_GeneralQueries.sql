-- COVID sheet


SELECT location
FROM covid
WHERE continent = 'Europe';


SELECT *
FROM covid
WHERE new_cases > 100 AND (location <> 'Spain')
ORDER BY new_cases desc;

SELECT * 
FROM covid
WHERE continent IN ('Europe','Asia')
ORDER BY location asc;

SELECT * 
FROM covid
WHERE location LIKE '%Republic%'
ORDER BY location asc;

SELECT * 
FROM covid
WHERE location LIKE '%Korea%'
ORDER BY location asc;


SELECT * 
FROM covid
WHERE location NOT LIKE '%a%' AND (location NOT LIKE '%A%')
ORDER BY location asc;

SELECT *
FROM covid
WHERE location IN ('France', 'Germany', 'Spain');

SELECT *
FROM covid
WHERE total_deaths BETWEEN 20000 AND 30000;


SELECT Location, total_cases
FROM covid
WHERE total_cases <= 1000
ORDER BY total_cases desc;


SELECT Location, total_cases
FROM covid
WHERE total_deaths >50000
ORDER BY total_deaths desc;


SELECT Location, total_cases
FROM covid
WHERE total_cases >50000
ORDER BY total_cases desc;


--- Deal with NULL

SELECT Location, total_cases, continent
FROM covid
WHERE continent = 'Europe' AND (total_cases IS NOT NULL)
ORDER BY total_cases desc
LIMIT 3;

SELECT Location, total_cases, continent
FROM covid
WHERE continent = 'Asia' AND (total_cases IS NOT NULL)
ORDER BY total_cases asc
LIMIT 3;

--- Laos, Timor, Brunei

"""
Note that NULL = unkown/inapplicable in the ternary system.
However, some time NULL has meaning as 'Not...'. 
For example, if to filtering using pet's breed, NULL means it is not that breed.
In this case, NULL rows should be returned instead of ignored. 
Only in Postegres, the following functions are available:
    - IN NOT TRUE
    - IS DISCTINCT FROM
"""
SELECT *
FROM Animals
WHERE Breed != 'Bullmastiff'
-- This will ignore NULL values, which is incorrect, instead:

SELECT *
FROM Animals
WHERE Breed IS DISTINCT FROM 'Bullmastiff';

-- OR

SELECT *
FROM Animals
WHERE (Breed = 'Bullmastiff') IS NOT TRUE;










SELECT Location, total_cases, continent
FROM covid
WHERE total_deaths > 1000 AND continent IN ('South America')
ORDER BY total_deaths asc;


SELECT location, CAST (total_deaths AS FLOAT) / total_cases AS ratio_deaths_cases
FROM covid
ORDER BY ratio_deaths_cases
LIMIT 1;