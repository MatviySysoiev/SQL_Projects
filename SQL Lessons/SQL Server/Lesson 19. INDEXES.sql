-- Indexes
SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers;

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID); -- You can create only one clustered index

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers;

SELECT
*
FROM Sales.DBCustomers
WHERE LastName = 'Brown';


CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName
ON Sales.DBCustomers (LastName);

CREATE INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName); -- also nonclustered


SELECT
	*
FROM Sales.DBCustomers
WHERE Country = 'USA' AND Score > 500;

CREATE INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (County, Score) -- the following things must be the same like in the query

SELECT
	*
FROM Sales.DBCustomers
WHERE Country = 'USA'; -- Also works with this index because starts with the same

SELECT
	*
FROM Sales.DBCustomers
WHERE Score > 500; -- won't work

A,B,C,D

-- Index will be used
A
A,B
A,B,C
-- Index won't be used
B
A,C
A,B,D
;

-- ROWSTORE and COLUMNSTORE Indexes
CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomer_CS -- you can create only one column store index
ON Sales.DBCustomers;

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers;

-- UNIQUE Index doesn't allow duplicated

SELECT * FROM Sales.Products;

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Product
ON Sales.Products (Product); -- You can't insert any duplicated there

INSERT INTO Sales.Products (ProductID, Product) VALUES (106, 'Caps'); -- error

-- FILTERED INDEXES

SELECT * FROM Sales.Customers
WHERE Country = 'USA';

CREATE NONCLUSTERED INDEX idx_Customers_Country
ON Sales.Customers (Country)
WHERE Country = 'USA'; 

-- Monitoring Index Usage. REALLY USEFUL.

sp_helpindex 'Sales.DBCustomers';

SELECT * FROM sys.dm_db_index_usage_stats;

SELECT 
	tbl.name TableName,
	idx.name IndexName,
	idx.type_desc IndexType,
	idx.is_primary_key IsPrimaryKey,
	idx.is_unique IsUnique,
	idx.is_disabled IsDisabled,
	s.user_seeks,
	s.user_scans,
	s.user_lookups,
	s.user_updates,
	s.last_user_seek,
	s.last_user_scan
FROM sys.indexes idx
JOIN sys.tables tbl
	ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats s
	ON s.object_id = idx.object_id
AND s.index_id = idx.index_id
ORDER BY tbl.name, idx.name;

SELECT * FROM sys.dm_db_missing_index_details; -- find missing indexes, recommendations

-- Find Duplicates
SELECT
    tbl.name AS TableName,
    col.name AS IndexColumn,
    idx.name AS IndexName,
    idx.type_desc AS IndexType,
	COUNT(*) OVER(PARTITION BY tbl.name, col.name) ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl 
    ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic 
    ON idx.object_id = ic.object_id 
    AND idx.index_id = ic.index_id
JOIN sys.columns col 
    ON ic.object_id = col.object_id 
    AND ic.column_id = col.column_id
ORDER BY ColumnCount DESC;

SELECT
    SCHEMA_NAME(t.schema_id) AS SchemaName,
    t.name AS TableName,
    s.name AS StatisticName,
    sp.last_updated AS LastUpdate,
    DATEDIFF(day, sp.last_updated, GETDATE()) AS LastUpdateDay,
    sp.rows AS 'Rows',
    sp.modification_counter AS ModificationsSinceLastUpdate
FROM sys.stats AS s
JOIN sys.tables t 
    ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
ORDER BY sp.modification_counter DESC;

UPDATE STATISTICS Sales.Customers _WA_Sys_00000005_48CFD27E -- update statistic about tables
UPDATE STATISTICS Sales.Customers -- update all table statistics
EXEC sp_updatestats; -- update all statistics (may take long time)

SELECT *
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED') -- avg_fragmenation_in_percent has to be 0
/* < 10% No action needed
10-30% Reorganize
>30% Rebuild */ 

ALTER INDEX idx_DBCustomer_CS ON Sales.DBCustomers REORGANIZE; -- or Rebuild (heavier)

SELECT *
FROM Sales.DBCustomers
WHERE FirstName LIKE '%A%'

SELECT *
FROM Sales.TestCustomers;

SELECT
	o.Sales,
	c.Country
FROM Sales.Orders o
LEFT JOIN Sales.Customers c WITH (INDEX([PK_customers]))
	ON o.CustomeriD = c.CustomerID
--OPTION (HASH JOIN)







































