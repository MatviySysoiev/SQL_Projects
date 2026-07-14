-- VIEWS
-- Find the running total of sales for each month

-- Views temp queries

CREATE VIEW V_Monthly_Summary AS (
	SELECT
			DATETRUNC(month, OrderDate) OrderMonth,
			SUM(Sales) TotalSales,
			COUNT(OrderID) TotalOrders,
			SUM(Quantity) TotalQuantities
		FROM Sales.Orders
		GROUP BY DATETRUNC(month, OrderDate)
);

SELECT
	OrderMonth,
	TotalSales,
	SUM(TotalSales) OVER(ORDER BY OrderMonth) RunningTOtal
FROM V_Monthly_Summary