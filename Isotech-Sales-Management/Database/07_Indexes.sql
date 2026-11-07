
/*
    PROJECT: Isotech Sales Management
    DATABASE: IsotechSalesDB
    FILE: 07_Indexes.sql
    PURPOSE: Create indexes to improve query performance.
*/

USE IsotechSalesDB;
GO

/*==============================================================
  1. INDEX - Search customers by email
==============================================================*/
CREATE NONCLUSTERED INDEX IX_Customers_Email
ON dbo.Customers (Email)
WHERE Email IS NOT NULL;
GO

/*==============================================================
  2. INDEX - Search orders by order date
==============================================================*/
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate
ON dbo.Orders (OrderDate);
GO

/*==============================================================
  3. VERIFY - List created indexes
==============================================================*/
SELECT
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique AS IsUnique
FROM sys.indexes i
INNER JOIN sys.tables t
    ON i.object_id = t.object_id
WHERE i.name IN (
    N'IX_Customers_Email',
    N'IX_Orders_OrderDate'
)
ORDER BY t.name;
GO
