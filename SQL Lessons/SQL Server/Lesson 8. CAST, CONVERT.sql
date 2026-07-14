SELECT
	FORMAT(OrderDate, 'MMMM yyyy') OrderDate,
	Count(*) as totalOrders
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMMM yyyy');



-- CONVERT converts a date or time value to a different data type and formats the value.  Any type to Any Type
SELECT
	CONVERT(INT, '123') [str to int],
	CONVERT(DATE, '2025-08-20') [str to date],
	CreationTime,
	CONVERT(DATE, CreationTime) [Datetime to Date],
	CONVERT(VARCHAR, CreationTime, 32) Style_USA, -- 32 means USA style
	CONVERT(VARCHAR, CreationTime, 34) Style_Europe
FROM Sales.Orders;

-- CAST convers one datatype to another, separated by AS. Any type to Any Type

SELECT
CAST('123' AS INT) [STR TO INT]

-- DATEADD add something DATEADD(part, interval, date) part - year for example.
SELECT
	OrderID,
	OrderDate,
	DATEADD(month, 3, OrderDate) threemonthLater,
	DATEADD(day, -10, OrderDate) threeDaysBefore
FROM Sales.Orders;

-- datediff founds the difference between two dates DATEDIFF(part, start_date, end_date) part for example year, day
SELECT
	EmployeeID,
	BirthDate,
	DATEDIFF(year, BirthDate, GETDATE()) as age
FROM Sales.Employees;

-- Find the average shipping duration in days for each month
SELECT
	DATENAME(MONTH, OrderDate) as OrderDate,
	CAST(AVG(DATEDIFF(day, OrderDate, ShipDate)) AS VARCHAR(5)) + ' Days' AvgShippingTime
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate);


SELECT
	OrderID,
	OrderDate CurrentOrderDate,
	LAG(OrderDate) OVER(ORDER BY OrderDate) PrevOrderDate,
	DATEDIFF(day, LAG(OrderDate) OVER(ORDER BY OrderDate), OrderDate) NumOfDays
FROM Sales.Orders;

-- ISDATE(value) returns 1 if it's a date, returns 0 if it's not
SELECT
	ISDATE('123') DateCheck1, -- 0
	ISDATE('2025-08-20') DateCheck2, -- 1
	ISDATE('20-08-2025') DateCheck3, -- 0 because you have to use static format
	ISDATE('2025') DateCheck4, -- 1
	ISDATE('08') -- 0
;

SELECT
	OrderDate,
	CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE) ELSE '9999-01-01' END NewOrderDate
FROM
(
	SELECT '20-08-2025' AS OrderDate UNION
	SELECT '21-08-2025' UNION
	SELECT '23-08-2025' UNION
	SELECT '2025-08'
) t
















