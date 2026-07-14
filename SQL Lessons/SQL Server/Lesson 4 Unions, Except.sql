USE SalesDB;

SELECT
	o.OrderID,
	CONCAT(c.FirstName, ' ', c.LastName) as Customer,
	pr.[Product],
	o.Sales,
	pr.Price,
	CONCAT(e.FirstName, ' ', e.LastName) as Saler
FROM Sales.Orders o
LEFT JOIN Sales.Customers c
	ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products pr
	on	o.ProductID = pr.ProductID
LEFT JOIN Sales.Employees e
	ON o.SalesPersonID = e.EmployeeID
ORDER BY Customer;

SELECT
FirstName,
LastName
FROM Sales.Employees
EXCEPT
SELECT
FirstName,
LastName
FROM Sales.Customers;

SELECT
FirstName,
LastName
FROM Sales.Employees e
WHERE NOT EXISTS (
	SELECT 1
	FROM Sales.Customers c
	WHERE e.FirstName = c.FirstName and e.LastName = c.LastName
);

-- Intersect returns values that are in both tables

SELECT
FirstName,
LastName
FROM Sales.Employees
INTERSECT
SELECT
FirstName,
LastName
FROM Sales.Customers;

-- Task

SELECT 'Orders' as SourceTable
       ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT 'Orders Archive' as SourceTable
       ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive;






 

