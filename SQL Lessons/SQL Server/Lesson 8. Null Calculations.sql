CREATE TABLE Null_Practice(
	ID INT primary key not null,
	First_Name VARCHAR(15) not null,
	Last_Name VARCHAR(15) NOT NULL,
	Email VARCHAR(30),
	Phone VARCHAR(15),
	[Adress] VARCHAR(50)
)

INSERT INTO Null_Practice(ID, First_Name, Last_Name, Email, Phone, Adress)
VALUES
	(1, 'Matthew', 'Rich', 'matviysysoiev2011@icloud.com', null, null),
	(2, 'Andrew', 'Winchester', null, '+380673859945', 'Rich person 1D'),
	(3, 'Timofei', 'Tiurne', null, null, null),
	(4, 'Anya', 'Molchanove', 'anyamolchanova0705@gmail.com', '+380682124727', 'Rich strees 2K');
-- ISNULL(value, replacement) ONLY 2 ARGUMENTS AND ONLY SQL SERVER If value is not null - then value, If value is null - then replacement
-- MYSQL IFNULL, Oracle NVL
SELECT ISNULL(Email, Phone) as contact_form
FROM Null_Practice;

-- COALESCE(value1, value2, value3, ...) returns the first value which is not null SLOWER THAN IS NULL
SELECT first_name, last_name, COALESCE(Email, Phone, Adress, 'No DATA') as contact_form
FROM Null_Practice;

SELECT
	CustomerID,
	Score,
	AVG(Score) OVER() AvgScores,
	AVG(ISNULL(Score, 0)) OVER() Avg_Score2, -- you have to handle the nulls
	COUNT(*) OVER() total
FROM
	Sales.Customers;


SELECT
	CustomerID,
	FirstName,
	LastName,
	CONCAT(FirstName, ' ', ISNULL(LastName, '')) as FullName,
	score,
	ISNULL(score, 0) + 10 as total_score
FROM Sales.Customers;

-- SORT THE CUSTOMERS FROM LOWEST TO HIGHEST SCORES WITH NULL APPEARING LAST

SELECT
	CustomerID,
	Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END
;

-- NULLIF(value1, value2) Compares value1 and value2, if they are NULL then NULL, if not then value1
SELECT
	OrderID,
	Sales,
	Quantity,
	Sales/NULLIF(Quantity, 0) as Price
FROM Sales.Orders;

-- Value IS NULL | returns true if value is null and return false if it's not
-- Value IS NOT NULL 


