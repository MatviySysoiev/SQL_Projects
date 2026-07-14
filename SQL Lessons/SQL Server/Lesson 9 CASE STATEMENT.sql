SELECT 
	FirstName,
	LastName,
	CASE Country -- only for =, doesn't work with <, >, etc.
		WHEN 'Germany' then 'GE'
		WHEN 'USA' then 'US'
		ELSE Country
	END CountryAbb
FROM Sales.Customers;

WITH cte_table AS (
	SELECT
	CustomerID,
	CONCAT(ISNULL(FirstName, ''), ' ', (ISNULL(LastName, ''))) Customer,
	CASE 
		WHEN Score IS NULL THEN 0
		ELSE Score
	END ScoreClean
	FROM Sales.Customers
)
SELECT
	CustomerID,
	Customer,
	ScoreClean,
	AVG(ScoreClean) OVER() AvgScore
FROM cte_table;

WITH cte_table AS (
	SELECT
	OrderID,
	CustomerID,
	Sales
FROM Sales.Orders
WHERE Sales > 30
)
SELECT
	CustomerID,
	Count(*) SalesMoreThan30
FROM cte_table
GROUP BY CustomerID;

SELECT
	CustomerID,
	SUM(CASE
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) Total_Orders
FROM Sales.Orders
GROUP BY CustomerID
ORDER BY CustomerID












