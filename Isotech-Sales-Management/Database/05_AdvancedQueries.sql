
/*
    PROJECT: Isotech Sales Management
    DATABASE: IsotechSalesDB
    FILE: 05_AdvancedQueries.sql
    PURPOSE: Advanced SELECT queries for sales management.
*/
use IsotechSalesDB;
GO
/*==============================================================
  1. JOIN - Display order and customer information
==============================================================*/
select
o.OrderID,
o.orderDate,
c.fullName as CustomerName,
c.email,
o.TotalAmount,
o.Status
from dbo.Orders o
inner join dbo.Customers c
    on o.CustomerID=c.CustomerID
order by o.orderDate desc;
GO
/*==============================================================
  2. GROUP BY - Total quantity sold by product
==============================================================*/
select
p.ProductID,
p.ProductName,
sum(od.Quantity) as TotalQuantitySold
from dbo.Products p
INNER JOIN dbo.OrderDetails od
    on p.ProductID=od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
order by TotalQuantitySold desc;
GO
/*==============================================================
    3. HAVING - Customers with more than 5 orders this month
==============================================================*/
select
c.CustomerID,
c.fullName,
count(o.OrderID) as TotalOrders
from dbo.Customers c
inner join dbo.Orders o
    on c.CustomerID=o.CustomerID
WHERE
    o.OrderDate >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
    AND o.OrderDate < DATEADD(
        MONTH, 1,
        DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
    )
GROUP BY
    c.CustomerID,
    c.fullName
HAVING
    count(o.OrderID) > 5
GO
/*==============================================================
4. REVENUE - Monthly revenue by year
  Only Completed orders are counted as revenue.
==============================================================*/
SELECT
    YEAR(OrderDate) AS RevenueYear,
    MONTH(OrderDate) AS RevenueMonth,
    SUM(TotalAmount) AS MonthlyRevenue
FROM dbo.Orders
WHERE Status = N'Completed'
GROUP BY
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY
    RevenueYear,
    RevenueMonth;
GO

/*==============================================================
  5. REVENUE - Total revenue by year
==============================================================*/
SELECT
    YEAR(OrderDate) AS RevenueYear,
    SUM(TotalAmount) AS YearlyRevenue
FROM dbo.Orders
WHERE Status = N'Completed'
GROUP BY YEAR(OrderDate)
ORDER BY RevenueYear;
GO


