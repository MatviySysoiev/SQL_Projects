/* SERVER
CACHE - temp data, fast read and write
DISK - all data. slow
DISK.Temp, DISK.CATALOG (metadata), DISK.USER (tables about users) */ 
SELECT
DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS -- METADATA (data about data)
;

-- SUBQUERIES
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	c.Score
FROM Sales.Customers c
WHERE NOT EXISTS (
	SELECT 1
	FROM Sales.Orders o
	WHERE o.CustomerID = c.CustomerID
);

SELECT
AVG(Sales) AS avg_sales
FROM Sales. Orders -- SCALAR SUBQUERY (single value)
;

SELECT
	CustomerID
FROM Sales.Orders; -- ROW SUBQUERY (multiple rows)

SELECT
	*
FROM Sales.Orders; -- TABLE SUBQUERY

SELECT
	*
FROM (
	SELECT
		ProductID,
		[Product],
		Price,
		AVG(Price) OVER() as avg_price
	FROM Sales.Products
) AS t
WHERE Price > avg_price;

SELECT *
FROM Sales.Customers;

SELECT *
FROM Sales.Orders;

SELECT
	*,
	DENSE_RANK() OVER(ORDER BY Total_Sales DESC) AS Ranking
FROM (
	SELECT
		c.CustomerID,
		CONCAT(c.FirstName, ' ', c.LastName) AS full_name,
		SUM(o.Sales) AS Total_Sales
	FROM Sales.Customers c
	INNER JOIN Sales.Orders o
		on c.CustomerID = o.CustomerID
	GROUP BY c.CustomerID, c.FirstName, c.LastName
) AS t
ORDER BY CustomerID;

SELECT
	ProductID,
	[Product],
	Price,
	(SELECT COUNT(*) FROM Sales.Orders) AS TotalOrders
FROM Sales.Products;

SELECT
	c.*,
	o.Total_Orders
FROM Sales.Customers c
LEFT JOIN (
	SELECT 
	CustomerID,
	COUNT(*) Total_Orders
	FROM Sales.Orders
	GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID






























