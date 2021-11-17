/*
Enter custom T-SQL here that would run after SQL Server has started up.
*/
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'testing_db')
BEGIN
CREATE DATABASE testing_db;
END;

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'aps_testing_db')
BEGIN
CREATE DATABASE aps_testing_db;
END;
