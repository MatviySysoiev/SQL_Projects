-- NTILE(value) ORDER BY is required. Divides rows into each packet. Value means how many rows in each packet
SELECT
OrderID,
Sales,
NTILE(2) OVER(ORDER BY Sales DESC) TwoBucket,
NTILE(3) OVER(ORDER BY Sales DESC) ThirdBucket
FROM Sales.Orders;
/* NTILE USE CASES.
DATA ANALYST - Data Segmentation
DATA ENGINEER _ Equalizing load processing */

WITH cte_table AS (
	SELECT 
		OrderID,
		ProductID,
		CustomerID,
		OrderDate,
		NTILE(3) OVER(ORDER BY Sales DESC) as nt
	FROM Sales.Orders
)
SELECT 
	OrderID,
	ProductID,
	CustomerID,
	OrderDate,
	CASE
		WHEN nt = 1 then 'High'
		WHEN nt = 2 then 'Medium'
		WHEN nt = 3 then 'Low'
		ELSE 'Unknown'
 	END as Sales_Category
FROM cte_table;


SELECT
	NTILE(2) OVER(ORDER BY OrderID),
	*
FROM Sales.Orders;
-- DIVIDING DATABASE IN SOME PARTS CAN HELP TO SEND Data from DATABASE A to DATABASE B.

-- find the products that fall within the highest 40% of the prices

WITH cte_t AS (
	SElECT
		Product,
		Price,
		CUME_DIST() OVER(ORDER BY Price DESC) DistRank
	FROM Sales.Products
)
SELECT *,
CONCAT(DistRank * 100, '%') DistRankPerc
FROM cte_t
WHERE DistRank <= 0.4;

-- LEAD(expr (req), offset(opt def = 1), def_value(opt, returns default value it next/prev row is not available, def = null))
-- OVER(PARTITION BY ProductID (opt) ORDER BY OrderDate (req))
-- access a value from the next row within a window
-- LAG() access a value from the prev row within a window
-- LEAD() access a value from the next row within a window

-- Analyze the month-over-month (MOM) perfomance by finding the percentage change
-- in sales between the cur and prev months

WITH MonthlySales AS (
    SELECT
        YEAR(OrderDate) AS OrderYear,
        MONTH(OrderDate) AS OrderMonth,
        SUM(Sales) AS CurrentMonthSales
    FROM Sales.Orders
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
),
MOM_calc AS (
    SELECT 
        OrderYear,
        OrderMonth,
        CurrentMonthSales,
        LAG(CurrentMonthSales) OVER (ORDER BY OrderYear, OrderMonth) AS PrevMonthSales
    FROM MonthlySales
)
SELECT 
    OrderYear,
    OrderMonth,
    CurrentMonthSales,
    PrevMonthSales,
    (CurrentMonthSales - PrevMonthSales) AS MOM_change,
    CASE 
        WHEN PrevMonthSales IS NULL OR PrevMonthSales = 0 THEN NULL 
        ELSE ROUND(((CurrentMonthSales - PrevMonthSales) * 100.0 / PrevMonthSales), 2) 
    END AS MOM_Perc_Value
FROM MOM_calc;

-- Rank customers based on the average days between their orders.

WITH cte_table AS (
	SELECT
		OrderID,
		CustomerID,
		OrderDate CurOrder,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder
	FROM Sales.Orders
),
cte_table2 AS(
	SELECT 
		*,
		DATEDIFF(DAY, CurOrder, NextOrder) as DaysUntilNextOrder
	FROM cte_table
)
SELECT 
	CustomerID,
	AVG(DaysUntilNextOrder) AvgDays,
	CASE AVG(DaysUntilNextOrder)
		WHEN NULL THEN NULL
		ELSE AVG(DaysUntilNextOrder)
	END AS RankAvg
FROM cte_table2
GROUP BY CustomerID;


-- FIRST_VALUE(Value) OVER(PARTITION BY (opt) ORDER BY (req)) -- takes the first value
-- LAST_VALUE(Value) OVER(PARTITION BY opt) ORDER BY(req) ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- Find the lowest and the highest sales for each product
SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales
FROM Sales.Orders























