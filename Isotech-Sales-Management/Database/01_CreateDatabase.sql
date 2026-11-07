
-- ==========================================
-- DU AN: QUAN LY HOAT DONG KINH DOANH ISOTECH
-- Buoc 1: Tao co so du lieu
-- ==========================================

-- Kiem tra database da ton tai chua
IF DB_ID(N'IsotechSalesDB') IS NULL
BEGIN
    CREATE DATABASE IsotechSalesDB;
    PRINT N'Tao database thanh cong!';
END
ELSE
BEGIN
    PRINT N'Database da ton tai!';
END
GO

-- Su dung database
USE IsotechSalesDB;
GO

-- Kiem tra database hien tai
SELECT
    DB_NAME() AS CurrentDatabase;
GO
