-- CTE (Common table expression)

WITH cte_total_sales AS
(
	SELECT
		CustomerID,
		SUM(Sales) As TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
),
cte_last_orders AS
(
	SELECT
		CustomerID,
		MAX(OrderDate) last_orderdate
	FROM Sales.Orders
	GROUP BY CustomerID
)
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.TotalSales,
	cls.last_orderdate
FROM Sales.Customers c
LEFT JOIN cte_total_sales cts
	ON cts.CustomerID = c.CustomerID
LEFT JOIN cte_last_orders cls
	ON cls.CustomerID = cts.CustomerID;

WITH cte_total_sales AS
(
	SELECT
		CustomerID,
		SUM(Sales) Total_Sales,
		MAX(OrderDate) Last_OrderDate
	FROM Sales.Orders
	GROUP BY CustomerID
),
cte_ranking_based_on_sales AS
(
	SELECT
		CustomerID,
		Total_Sales,
		Last_OrderDate,
		DENSE_RANK() OVER(ORDER BY Total_Sales DESC) Ranking,
		CASE 
			WHEN Total_Sales < 60 THEN 'Low'
			WHEN Total_Sales BETWEEN 50 AND 100 THEN 'Medium'
			WHEN Total_Sales > 100 THEN 'High'
			ELSE 'Unknown'
		END AS SalesCategory
	FROM cte_total_sales
)
SELECT
	ts.CustomerID,
	CONCAT(sc.FirstName, ' ', sc.LastName) CustomerFullName,
	ts.Total_Sales,
	ts.Ranking,
	ts.Last_OrderDate,
	ts.SalesCategory
FROM cte_ranking_based_on_sales ts
LEFT JOIN Sales.Customers sc
	ON ts.CustomerID = sc.CustomerID





