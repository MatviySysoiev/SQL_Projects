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










