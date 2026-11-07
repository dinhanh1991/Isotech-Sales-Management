/*
    PROJECT: Isotech Sales Management
    DATABASE: IsotechSalesDB
    FILE: 09_Testing.sql
    PURPOSE: Test database structure and objects.
*/

USE IsotechSalesDB;
GO

/*==============================================================
  1. TEST - Check database connection
==============================================================*/
SELECT
    DB_NAME() AS CurrentDatabase,
    @@SERVERNAME AS ServerName;
GO

/*==============================================================
  2. TEST - Check all six tables
==============================================================*/
SELECT
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

/*==============================================================
  3. TEST - Check record counts
==============================================================*/
SELECT 'Customers' AS TableName, COUNT(*) AS TotalRecords FROM dbo.Customers
UNION ALL
SELECT 'Categories', COUNT(*) FROM dbo.Categories
UNION ALL
SELECT 'Employees', COUNT(*) FROM dbo.Employees
UNION ALL
SELECT 'Products', COUNT(*) FROM dbo.Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM dbo.Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM dbo.OrderDetails;
GO
/*==============================================================
  4. TEST - Check Views
==============================================================*/
SELECT name AS ViewName
FROM sys.views
WHERE name IN (
    N'vw_OrderDetails',
    N'vw_LowStockProducts',
    N'vw_Top5Customers'
)
ORDER BY name;
GO

/*==============================================================
  5. TEST - Check Stored Procedures
==============================================================*/
SELECT name AS ProcedureName
FROM sys.procedures
WHERE name IN (
    N'sp_AddNewOrder',
    N'sp_GetRevenueByDateRange',
    N'sp_GetBestSellingProducts'
)
ORDER BY name;
GO
/*==============================================================
  6. TEST - Check Foreign Keys
==============================================================*/
SELECT
    OBJECT_NAME(parent_object_id) AS TableName,
    name AS ForeignKeyName,
    OBJECT_NAME(referenced_object_id) AS ReferencedTable
FROM sys.foreign_keys
ORDER BY TableName, ForeignKeyName;
GO
/*==============================================================
  7. TEST - Check database integrity
==============================================================*/
DBCC CHECKCONSTRAINTS WITH ALL_CONSTRAINTS;
GO