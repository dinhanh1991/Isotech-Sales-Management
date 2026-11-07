
/*
    PROJECT: Isotech Sales Management
    DATABASE: IsotechSalesDB
    FILE: 08_StoredProcedures.sql
    PURPOSE: Create stored procedures for sales management.
*/

USE IsotechSalesDB;
GO

/*==============================================================
  1. PROCEDURE - Add a new order
==============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_AddNewOrder
    @CustomerID INT,
    @EmployeeID INT,
    @OrderID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Orders
        (CustomerID, EmployeeID, TotalAmount, Status)
    VALUES
        (@CustomerID, @EmployeeID, 0, N'Pending');

    SET @OrderID = SCOPE_IDENTITY();

    SELECT
        @OrderID AS NewOrderID,
        N'Order created successfully' AS Message;
END;
GO
/*==============================================================
  2. PROCEDURE - Get revenue by date range
==============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_GetRevenueByDateRange
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        CAST(o.OrderDate AS DATE) AS RevenueDate,
        COUNT(o.OrderID) AS TotalOrders,
        SUM(o.TotalAmount) AS TotalRevenue
    FROM dbo.Orders o
    WHERE
        o.Status = N'Completed'
        AND o.OrderDate >= @StartDate
        AND o.OrderDate < DATEADD(DAY, 1, @EndDate)
    GROUP BY CAST(o.OrderDate AS DATE)
    ORDER BY RevenueDate;
END;
GO
/*==============================================================
  3. PROCEDURE - Get best-selling products
==============================================================*/
CREATE OR ALTER PROCEDURE dbo.sp_GetBestSellingProducts
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 5
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity) AS TotalQuantitySold,
        SUM(od.Quantity * od.SalePrice) AS TotalRevenue
    FROM dbo.OrderDetails od
    INNER JOIN dbo.Products p
        ON od.ProductID = p.ProductID
    INNER JOIN dbo.Orders o
        ON od.OrderID = o.OrderID
    WHERE o.Status = N'Completed'
    GROUP BY
        p.ProductID,
        p.ProductName
    ORDER BY TotalQuantitySold DESC;
END;
GO