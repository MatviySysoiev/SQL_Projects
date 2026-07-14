-- VIEWS
-- Find the running total of sales for each month

-- Views temp queries
IF OBJECT_ID ('Sales.V_Monthly_Summary', 'V') IS NOT NULL
	DROP VIEW Sales.V_Monthly_Summary;
GO
CREATE VIEW Sales.V_Monthly_Summary AS ( -- "Sales" to specify schema
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
	SUM(TotalSales) OVER(ORDER BY OrderMonth) RunningTotal
FROM V_Monthly_Summary;

DROP VIEW Sales.V_Monthly_Summary; -- delete

-- TASK: Provide view that combines details from orders, products, customers and employees

CREATE VIEW Sales.V_Order_Details AS (
	SELECT
		o.OrderID,
		o.OrderDate,
		p.[Product],
		p.Category,
		CONCAT(c.FirstName, ' ', c.LastName) Customer,
		c.Country CustomerCountry,
		CONCAT(e.FirstName, ' ', e.LastName) Employee,
		e.Department,
		o.Sales,
		o.Quantity
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p
		ON o.ProductID = p.ProductID
	LEFT JOIN Sales.Customers c
		ON o.CustomerID = c.CustomerID
	LEFT JOIN Sales.Employees e
		ON e.EmployeeID = o.SalesPersonID
);

SELECT *
FROM Sales.V_Order_Details;

/* Prodide a view for EU Sales Team
that combines details from all tables
and excludes Data related to USA */ 

CREATE VIEW Sales.V_Order_Details_EU AS (
	SELECT
			o.OrderID,
			o.OrderDate,
			p.[Product],
			p.Category,
			CONCAT(c.FirstName, ' ', c.LastName) Customer,
			c.Country CustomerCountry,
			CONCAT(e.FirstName, ' ', e.LastName) Employee,
			e.Department,
			o.Sales,
			o.Quantity
		FROM Sales.Orders o
		LEFT JOIN Sales.Products p
			ON o.ProductID = p.ProductID
		LEFT JOIN Sales.Customers c
			ON o.CustomerID = c.CustomerID
		LEFT JOIN Sales.Employees e
			ON e.EmployeeID = o.SalesPersonID
	WHERE c.Country != 'USA'
)



















