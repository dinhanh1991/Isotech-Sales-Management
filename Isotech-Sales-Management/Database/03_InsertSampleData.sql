/*
    PROJECT: Isotech Sales Management
    DATABASE: IsotechSalesDB
    FILE: 03_InsertSampleData.sql
    PURPOSE: Insert sample data into master tables.
*/

USE IsotechSalesDB;
GO

/*==============================================================
  1. CATEGORIES - Product categories
==============================================================*/
INSERT INTO dbo.Categories (CategoryName, Description)
VALUES
    (N'Vật liệu xây dựng', N'Các loại vật liệu phục vụ xây dựng'),
    (N'Thiết bị điện', N'Thiết bị và vật tư ngành điện'),
    (N'Thiết bị công nghiệp', N'Máy móc và thiết bị công nghiệp');
GO
/*==============================================================
  2. EMPLOYEES - Employee information
==============================================================*/
INSERT INTO dbo.Employees (FullName, [Position], Phone, Email)
VALUES
    (N'Nguyễn Văn An', N'Nhân viên kinh doanh', '0901000001', 'an@isotech.vn'),
    (N'Trần Thị Bình', N'Nhân viên kinh doanh', '0901000002', 'binh@isotech.vn'),
    (N'Lê Văn Cường', N'Quản lý kinh doanh', '0901000003', 'cuong@isotech.vn');
GO
/*==============================================================
  3. CUSTOMERS - Customer information
==============================================================*/
INSERT INTO dbo.Customers (FullName, Address, Email, Phone)
VALUES
    (N'Công ty Minh Phát', N'Hà Nội', 'minhphat@example.com', '0912000001'),
    (N'Công ty Thành Công', N'Hải Phòng', 'thanhcong@example.com', '0912000002'),
    (N'Công ty Hoàng Long', N'Nghệ An', 'hoanglong@example.com', '0912000003'),
    (N'Công ty Đại Việt', N'Thanh Hóa', 'daiviet@example.com', '0912000004'),
    (N'Công ty An Phú', N'Bắc Ninh', 'anphu@example.com', '0912000005');
GO

/*==============================================================
  4. PRODUCTS - Product information
==============================================================*/
INSERT INTO dbo.Products
    (ProductName, CategoryID, UnitPrice, Description, StockQuantity)
VALUES
    (N'Xi măng PCB40', 1, 95000, N'Bao xi măng 50kg', 500),
    (N'Thép xây dựng D16', 1, 185000, N'Thép cây phi 16', 300),
    (N'Cát xây dựng', 1, 350000, N'Cát xây dựng tính theo m3', 100),
    (N'Dây điện Cadivi 2.5mm', 2, 450000, N'Cuộn dây điện', 80),
    (N'CB chống giật', 2, 650000, N'Thiết bị bảo vệ điện', 50),
    (N'Máy bơm công nghiệp', 3, 5500000, N'Máy bơm nước công nghiệp', 20),
    (N'Motor điện 3 pha', 3, 7800000, N'Động cơ điện công nghiệp', 15),
    (N'Quạt thông gió công nghiệp', 3, 3200000, N'Thiết bị thông gió', 25);
GO

/*==============================================================
  6. ORDERS - Sales orders
==============================================================*/
INSERT INTO dbo.Orders
    (OrderDate, CustomerID, EmployeeID, TotalAmount, Status)
VALUES
    ('2026-10-05 09:30:00', 1, 1, 0, N'Completed'),
    ('2026-10-10 10:15:00', 2, 2, 0, N'Completed'),
    ('2026-10-15 14:00:00', 3, 1, 0, N'Completed'),
    ('2026-10-20 08:45:00', 1, 3, 0, N'Confirmed'),
    ('2026-11-02 11:20:00', 4, 2, 0, N'Pending'),
    ('2026-11-05 15:30:00', 5, 3, 0, N'Pending');
GO

/*==============================================================
  7. ORDER DETAILS - Order line items
==============================================================*/
INSERT INTO dbo.OrderDetails
    (OrderID, ProductID, Quantity, SalePrice)
VALUES
    (1, 1, 20, 95000),
    (1, 2, 10, 185000),
    (2, 4, 5, 450000),
    (2, 5, 3, 650000),
    (3, 6, 2, 5500000),
    (3, 7, 1, 7800000),
    (4, 1, 30, 95000),
    (4, 3, 10, 350000),
    (5, 4, 2, 450000),
    (6, 8, 3, 3200000);
GO

/*==============================================================
  8. UPDATE ORDER TOTALS
==============================================================*/
UPDATE o
SET TotalAmount = d.OrderTotal
FROM dbo.Orders o
JOIN
(
    SELECT
        OrderID,
        SUM(Quantity * SalePrice) AS OrderTotal
    FROM dbo.OrderDetails
    GROUP BY OrderID
) d ON o.OrderID = d.OrderID;
GO

/*==============================================================
  9. VERIFY - Display all inserted tables
==============================================================*/
SELECT * FROM dbo.Categories ORDER BY CategoryID;
SELECT * FROM dbo.Employees ORDER BY EmployeeID;
SELECT * FROM dbo.Customers ORDER BY CustomerID;
SELECT * FROM dbo.Products ORDER BY ProductID;
SELECT * FROM dbo.Orders ORDER BY OrderID;
SELECT * FROM dbo.OrderDetails ORDER BY OrderID, ProductID;
GO
