/*
PROJECT: Isotech Sale Mângement
DATA BASE: IsotechSaleDB
FILE: 02_CreateTables.sql
PURPOSE: Create the 6 core and extended tables.


*/
USE IsotechSaleDB;
GO
USE IsotechSalesDB;
GO
/*==============================================================
  1. CUSTOMERS - Customer information
==============================================================*/
IF OBJECT_ID(N'dbo.CUSTOMERS', N'U') IS NOT NULL
BEGIN
    CREATE TABLE dbo.CUSTOMERS
    (
         CustomerID INT IDENTITY(1,1) NOT NULL,
        FullName NVARCHAR(100) NOT NULL,
        Address NVARCHAR(255) NULL,
        Email VARCHAR(100) NULL,
        Phone VARCHAR(15) NULL,

        CONSTRAINT PK_Customers
            PRIMARY KEY (CustomerID)
    );
END
GO
/*==============================================================
  2. CATEGORIES - Product categories
==============================================================*/
IF OBJECT_ID(N'dbo.CATEGORIES', N'U') IS NOT NULL
BEGIN
    CREATE TABLE dbo.CATEGORIES
    (
         CategoryID INT IDENTITY(1,1) NOT NULL,
        CategoryName NVARCHAR(100) NOT NULL,
        Description NVARCHAR(255) NULL,

        CONSTRAINT PK_Categories
            PRIMARY KEY (CategoryID),

        CONSTRAINT UQ_Categories_CategoryName
            UNIQUE (CategoryName)
    );
END
GO
/*==============================================================
  3. EMPLOYEES - Employee information
==============================================================*/
IF OBJECT_ID(N'dbo.EMPLOYEES', N'U') IS NOT NULL
BEGIN
    CREATE TABLE dbo.EMPLOYEES
    (
            EmployeeID INT IDENTITY(1,1) NOT NULL,
            FullName NVARCHAR(100) NOT NULL,
            Position NVARCHAR(50) NULL,
            Phone VARCHAR(15) NULL,
            Email VARCHAR(100) NULL,

            constraint PK_Employees
                PRIMARY KEY (EmployeeID),
            constraint UQ_Employees_Email
                UNIQUE (Email)
    );
END;
GO
/*============================================================== 
    4. PRODUCTS - Product information and inventory
==============================================================*/
if OBJECT_ID(N'dbo.PRODUCTS', N'U') IS NOT NULL
BEGIN

    CREATE TABLE dbo.PRODUCTS
    (
        ProductID INT IDENTITY(1,1) NOT NULL,
        ProductName NVARCHAR(150) NOT NULL,
        CategoryID INT NOT NULL,
        UnitPrice DECIMAL(18, 2) NOT NULL,
        Description NVARCHAR(500) NULL,
        StockQuantity INT NOT NULL,

         CONSTRAINT PK_Products
            PRIMARY KEY (ProductID),

        CONSTRAINT FK_Products_Categories
            FOREIGN KEY (CategoryID)
            REFERENCES dbo.Categories(CategoryID),

        CONSTRAINT CK_Products_UnitPrice
            CHECK (UnitPrice > 0),

        CONSTRAINT CK_Products_StockQuantity
            CHECK (StockQuantity >= 0)
    );
END;
Go

/*==============================================================
  5. ORDERS - Sales orders
==============================================================*/
IF OBJECT_ID(N'dbo.Orders', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Orders
    (
        OrderID INT IDENTITY(1,1) NOT NULL,
        OrderDate DATETIME2(0) NOT NULL
            CONSTRAINT DF_Orders_OrderDate DEFAULT (SYSDATETIME()),

        CustomerID INT NOT NULL,
        EmployeeID INT NOT NULL,

        TotalAmount DECIMAL(18,2) NOT NULL
            CONSTRAINT DF_Orders_TotalAmount DEFAULT (0),

        Status NVARCHAR(30) NOT NULL
            CONSTRAINT DF_Orders_Status DEFAULT (N'Pending'),

        CONSTRAINT PK_Orders
            PRIMARY KEY (OrderID),

        CONSTRAINT FK_Orders_Customers
            FOREIGN KEY (CustomerID)
            REFERENCES dbo.Customers(CustomerID),

        CONSTRAINT FK_Orders_Employees
            FOREIGN KEY (EmployeeID)
            REFERENCES dbo.Employees(EmployeeID),

        CONSTRAINT CK_Orders_TotalAmount
            CHECK (TotalAmount >= 0),

        CONSTRAINT CK_Orders_Status
            CHECK (Status IN
                (N'Pending', N'Confirmed', N'Completed', N'Cancelled'))
    );
END;
GO

/*==============================================================
  6. ORDERDETAILS - Products belonging to each order
==============================================================*/
IF OBJECT_ID(N'dbo.OrderDetails', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.OrderDetails
    (
        OrderID INT NOT NULL,
        ProductID INT NOT NULL,
        Quantity INT NOT NULL,
        SalePrice DECIMAL(18,2) NOT NULL,

        CONSTRAINT PK_OrderDetails
            PRIMARY KEY (OrderID, ProductID),

        CONSTRAINT FK_OrderDetails_Orders
            FOREIGN KEY (OrderID)
            REFERENCES dbo.Orders(OrderID),

        CONSTRAINT FK_OrderDetails_Products
            FOREIGN KEY (ProductID)
            REFERENCES dbo.Products(ProductID),

        CONSTRAINT CK_OrderDetails_Quantity
            CHECK (Quantity > 0),

        CONSTRAINT CK_OrderDetails_SalePrice
            CHECK (SalePrice > 0)
    );
END;
GO

/*==============================================================
  7. VERIFICATION - Display created tables
==============================================================*/
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

PRINT N'Table creation script completed.';
GO