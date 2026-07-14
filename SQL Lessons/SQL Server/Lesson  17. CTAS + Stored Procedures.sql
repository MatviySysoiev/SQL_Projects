-- TEMP TABLES

SELECT
	*
INTO #Orders -- '#' means temporary. Without it it's gonna be CTAS
FROM Sales.Orders;

SELECT *
INTO Sales.OrdersTest
FROM #Orders;

-- STORED PROCEDURES
DROP PROCEDURE GetCustomerSummary;
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS -- = 'USA' means the default vale
BEGIN

	BEGIN TRY
		DECLARE @TotalCustomers INT, @AvgScore FLOAT;
		-- =================================
		-- Step 1: Prepare & Cleanup Data
		-- =================================
		IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS  NULL AND Country = @Country)
		BEGIN
			PRINT('Updating NULL Scores to 0')
			UPDATE Sales.Customers
			SET Score = 0
			WHERE Score IS NULL AND Country = @Country
		END
		ELSE
		BEGIN
			PRINT('No NULL Scores found')
		END

		-- =================================
		-- Step 2: GENERATING reports
		-- =================================
		-- CAlc Total Customers and Average Score for specific Country
			SELECT
				@TotalCustomers = COUNT(*), -- DECLARE value
				@AvgScore = AVG(Score) -- declare value
			FROM Sales.Customers
			WHERE Country = @Country;

			PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR); -- everything has to be the same data type
			PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR); -- everything has to be the same data type

			-- Calculate Total Number of Orders and Total Sales for specific
			SELECT
			COUNT(OrderID) TotalOrders,
			SUM(Sales) TotalSales
		FROM Sales.Orders o
		INNER JOIN Sales.Customers c
		ON c.CustomerID = o.CustomerID
		WHERE c.Country = @Country;
	END TRY

	-- =================================
	-- IF AN ERROR HAPPENS
	-- =================================
	BEGIN CATCH
		PRINT('An error has occured');
		PRINT('Error Message: ' + ERROR_MESSAGE());
		PRINT('Error Number: ' + CAST(ERROR_MESSAGE() AS NVARCHAR));
		PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('Error Procedure: ' + CAST(ERROR_PROCEDURE() AS NVARCHAR));
	END CATCH

END;

EXEC GetCustomerSummary @Country = 'USA'; -- We will execute 2 queries

