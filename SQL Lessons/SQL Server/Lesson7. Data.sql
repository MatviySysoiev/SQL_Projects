-- DATETRUNC limites data

SELECT 
	GETDATE() as current_day,
	DATETRUNC(DAY, GETDATE()) as day_limit;


SELECT
DATETRUNC(MONTH, CreationTime) creation,
COUNT(*) total
FROM SalesDB.Sales.Orders
GROUP BY DATETRUNC(MONTH, CreationTime);



-- EOMONTH(date) returns the last day of the month

SELECT
EOMONTH(CreationTime) EndOfMonth,
CAST(DATETRUNC(MONTH, CreationTime) AS DATE) StartofMonth -- cast removes all zeros
FROM Sales.Orders
GROUP BY EOMONTH(CreationTime),
CAST(DATETRUNC(MONTH, CreationTime) AS DATE);

-- How many orders were placed each month

SELECT
DATENAME(MONTH, OrderDate) as OrderDate,
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate);

SELECT
OrderID,
CreationTime,
FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format
FROM Sales.Orders;

SELECT
OrderID,
CreationTime,
'Day ' + FORMAT(CreationTime, 'ddd MMM ')
+ ' Q' +DATENAME(quarter, CreationTime)
+ ' ' + FORMAT(CreationTime, 'yyyy hh:mm:ss tt') CustomFormat
FROM Sales.Orders











