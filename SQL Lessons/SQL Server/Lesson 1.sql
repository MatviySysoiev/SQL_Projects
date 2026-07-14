USE	MyDatabase

-- This is a comment
/* this
is a 
comment
*/

SELECT *
FROM dbo.customers;

SELECT 
	order_id, 
	customer_id, 
	sales
FROM orders;

SELECT id, first_name, score
FROM customers
WHERE score != 0
;

SELECT *
FROM customers
WHERE country = 'Germany';

SELECT *
FROM customers
ORDER BY country DESC, score ASC
;

SELECT
	country,
	SUM(score) AS total_score,
	COUNT(*) AS total_customers
FROM customers
GROUP BY country;


SELECT 
	country, 
	AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430








