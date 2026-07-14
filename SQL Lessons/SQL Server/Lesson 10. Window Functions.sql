SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

-- FRAME means current row which is being occured + 2 next rown (following - preceding. unbounded - till the end)
-- SQL checks window functions after where clause!!

-- Rank Customers based on their total sales
-- FIRSTLY BUILD GROUP BY
-- then window functions
SELECT
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID





