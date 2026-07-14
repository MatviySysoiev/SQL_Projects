SELECT
3.516,
ROUND(3.516, 2) as [round2],
ROUND(3.516, 1) as [round1],
ROUND(3.516, 0) as [round0];

SELECT
-10,
ABS(-10),
ABS(10) -- DOES NOTHING;

SELECT
OrderID,
OrderDate,
ShipDate,
CreationTime,
GETDATE() Today,
MONTH(GetDate()) [Month], -- int
YEAR(GETDATE()) [Year], -- also int
DAY(GETDATE()) [Day], -- int again
DATEPART(year, GETDATE()) year_dp,
DATEPART(month, GETDATE()) month_dp,
DATEPART(day, GETDATE()) day_dp,-- int
DATEPART(hour, GETDATE()) hour_dp,
DATEPART(quarter, GETDATE()) quater_dp,
DATEPART(week, GETDATE()) weekday_dp,
DATENAME(weekday, GETDATE()) weekday_dn,
DATENAME(month, GETDATE()) month_dn,
DATENAME(day, GETDATE()) day_dn, -- string
DATENAME(year, GETDATE()) year_dn -- string
FROM Sales.Orders;









