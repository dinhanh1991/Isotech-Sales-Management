
/*
    PROJECT: Isotech Sales Management
    DATABASE: IsotechSalesDB
    FILE: 04_CRUD.sql
    PURPOSE: Demonstrate INSERT, SELECT, UPDATE and DELETE.
*/

USE IsotechSalesDB;
GO

/*==============================================================
  1. CUSTOMERS - Customer CRUD
==============================================================*/

-- 1.1. CREATE: Add a new customer
INSERT INTO dbo.Customers
    (FullName, Address, Email, Phone)
VALUES
    (N'Công ty Phúc An', N'Hà Nội',
     'phucan@example.com', '0912000006');
GO

-- 1.2. READ: Display customer information
SELECT *
FROM dbo.Customers
ORDER BY CustomerID;
GO

-- 1.3. UPDATE: Update customer information
UPDATE dbo.Customers
SET Address = N'Hà Nội - Việt Nam',
    Phone = '0912999999'
WHERE CustomerID = 1019;
GO

-- Check updated information
SELECT *
FROM dbo.Customers
WHERE CustomerID = 1019;
GO

-- 1.4. DELETE: Delete the test customer
DELETE FROM dbo.Customers
WHERE CustomerID =6;
GO

/*==============================================================
  2. PRODUCTS - Product CRUD
==============================================================*/

-- 2.1. CREATE: Add a new product
INSERT INTO dbo.Products
    (ProductName, CategoryID, UnitPrice, Description, StockQuantity)
VALUES
    (N'Bulong công nghiệp', 3, 15000,
     N'Bulong thép sử dụng trong công nghiệp', 200);
GO

-- 2.2. READ: Display product information
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.UnitPrice,
    p.StockQuantity
FROM dbo.Products p
JOIN dbo.Categories c
    ON p.CategoryID = c.CategoryID
ORDER BY p.ProductID;
GO

-- 2.3. UPDATE: Update product price and stock
UPDATE dbo.Products
SET UnitPrice = 18000,
    StockQuantity = 250
WHERE ProductID = 9;
GO

-- Check updated information
SELECT *
FROM dbo.Products
WHERE ProductID = 9;
GO

-- 2.4. DELETE: Delete the test product
DELETE FROM dbo.Products
WHERE ProductID = 9;
GO

/*==============================================================
  3. ORDERS - Order CRUD
==============================================================*/

-- 3.1. CREATE: Add a new order
INSERT INTO dbo.Orders
    (CustomerID, EmployeeID, TotalAmount, Status)
VALUES
    (2, 1, 0, N'Pending');
GO

-- 3.2. READ: Display order information
SELECT
    o.OrderID,
    o.OrderDate,
    c.FullName AS CustomerName,
    e.FullName AS EmployeeName,
    o.TotalAmount,
    o.Status
FROM dbo.Orders o
JOIN dbo.Customers c
    ON o.CustomerID = c.CustomerID
JOIN dbo.Employees e
    ON o.EmployeeID = e.EmployeeID
ORDER BY o.OrderID;
GO

-- 3.3. UPDATE: Update order status
UPDATE dbo.Orders
SET Status = N'Confirmed'
WHERE OrderID = 7;
GO

-- Check updated information
SELECT *
FROM dbo.Orders
WHERE OrderID = 7;
GO

-- 3.4. DELETE: Delete the test order
DELETE FROM dbo.Orders
WHERE OrderID = 7;
GO

