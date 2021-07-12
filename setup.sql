/*
Enter custom T-SQL here that would run after SQL Server has started up.
*/

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'testing_db')
BEGIN
CREATE DATABASE testing_db;
END;
GO
