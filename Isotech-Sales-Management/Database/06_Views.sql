
/*
    PROJECT: Isotech Sales Management
    DATABASE: IsotechSalesDB
    FILE: 06_Views.sql
    PURPOSE: Create views for sales management reports.
*/

USE IsotechSalesDB;
GO

/*==============================================================
  1. VIEW - Detailed order information
==============================================================*/
CREATE OR ALTER VIEW dbo.vw_OrderDetails
AS
SELECT
    o.OrderID,
    o.OrderDate,
    c.FullName AS CustomerName,
    p.ProductName,
    od.Quantity,
    od.SalePrice,
    od.Quantity * od.SalePrice AS LineTotal,
    o.Status
FROM dbo.Orders o
INNER JOIN dbo.Customers c
    ON o.CustomerID = c.CustomerID
INNER JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN dbo.Products p
    ON od.ProductID = p.ProductID;
GO

/*==============================================================
  2. VIEW - Products with low stock (below 50)
==============================================================*/
CREATE OR ALTER VIEW dbo.vw_LowStockProducts
AS
SELECT
    ProductID,
    ProductName,
    UnitPrice,
    StockQuantity
FROM dbo.Products
WHERE StockQuantity < 50;
GO

/*==============================================================
  3. VIEW - Top 5 customers by total order value
==============================================================*/
CREATE OR ALTER VIEW dbo.vw_Top5Customers
AS
SELECT TOP 5
    c.CustomerID,
    c.FullName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalOrderValue
FROM dbo.Customers c
INNER JOIN dbo.Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName
ORDER BY SUM(o.TotalAmount) DESC;
GO

/*==============================================================
  4. VERIFY - Test the created views
==============================================================*/
SELECT * FROM dbo.vw_OrderDetails;
GO

SELECT * FROM dbo.vw_LowStockProducts;
GO

SELECT * FROM dbo.vw_Top5Customers;
GO
