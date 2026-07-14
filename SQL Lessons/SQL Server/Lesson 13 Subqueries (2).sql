-- Find the products that have a price higher than the avg price of all products
SELECT
	ProductID,
	Price
FROM
	Sales.Products
WHERE Price > (
	SELECT AVG(Price)
	FROM Sales.Products
);

-- Show the details of orders made my customers in Germany
SELECT
	o.*
FROM Sales.Orders o
INNER JOIN Sales.Customers c
	ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany';

-- Not in Germany
SELECT
	o.*
FROM Sales.Orders o
INNER JOIN Sales.Customers c
	ON o.CustomerID = c.CustomerID
WHERE c.Country != 'Germany';

SELECT
	o.CustomerID
FROM Sales.Orders o
WHERE NOT EXISTS (
	SELECT 1
	FROM Sales.Customers c
	WHERE c.Country = 'Germany'
	AND  o.CustomerID = c.CustomerID
)
GROUP BY o.CustomerID;

-- Find female employees whose salaries are greater than the salaries of any male employees
SELECT
	EmployeeID,
	FirstName,
	Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M'); -- ANY, ALL, SOME

-- Shoe all customer details and find the total orders of each customer

SELECT
	*,
	(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID) TotalSales
FROM Sales.Customers c;

-- Show the details of orders made by customers in Germany
SELECT
	*
FROM Sales.Orders o
WHERE EXISTS (
	SELECT 1
	FROM Sales.Customers c
	Where c.Country = 'Germany'
	AND o.CustomerID = c.CustomerID
)








 








