-- Step 1:Partition Functions

CREATE PARTITION FUNCTION PartitionByYear (DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31', '2024-12-31', '2025-12-31');

SELECT
	name,
	function_id,
	type,
	type_desc,
	boundary_value_on_right
FROM sys.partition_functions;

-- Step 2: Create Filegroups

ALTER DATABASE SalesDB ADD FILEGROUP FG_2023;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2024;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2025;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2026;

ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023;

SELECT *
FROM sys.filegroups
WHERE type = 'FG';

-- STEP 3: Add .ndf Files to Each Filegroup
ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2023,
	FILENAME = 'D:\PostgreSQL\Microsoft Server SQL\MSSQL17.SQLEXPRESS\MSSQL\DATA'
) TO FILEGROUP FG_2023;

SELECT
	fg.name AS FilegroupName,
	mf.name LogicalFileName,
	mf.physical_name PhysicalFilePath,
	mf.size / 128 SizeInMB
FROM sys.filegroups fg
JOIN sys.master_files mf ON fg.data_space_id = mf.data_space_id
WHERE mf.database_id = DB_ID('SalesDB');

 CREATE PARTITION SCHEME SchemePartitionByYear
 AS PARTITION PartitionByYear
 TO (FG_2023, FG_2024, FG_2025, FG_2026);

SELECT
    ps.name AS PartitionSchemeName,
    pf.name AS PartitionFunctionName,
    ds.destination_id AS PartitionNumber,
    fg.name AS FilegroupName
FROM sys.partition_schemes ps
JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
JOIN sys.destination_data_spaces ds ON ps.data_space_id = ds.partition_scheme_id
JOIN sys.filegroups fg ON ds.data_space_id = fg.data_space_id









