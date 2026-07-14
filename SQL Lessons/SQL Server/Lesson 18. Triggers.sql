ALTER TABLE Sales.EmployeeLogs (
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate Date
;

CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT -- Also you can use instead off
AS
BEGIN
	INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
	SELECT
		EmployeeID,
		'New Employeed Added = ' + CAST(EmployeeID AS VARCHAR),
		GETDATE()
	FROM inserted
END;

SELECT * FROM Sales.EmployeeLogs;

INSERT INTO Sales.Employees
VALUES
(6, 'Maria', 'Doe', 'HR', '1988-02-09', 'F', 80000, 3);















