# ISOTECH SALES MANAGEMENT
## Hệ thống quản lý hoạt động kinh doanh Isotech

### 1. Giới thiệu dự án

**Isotech Sales Management** là dự án xây dựng cơ sở dữ liệu quản lý hoạt động kinh doanh cho Công ty Isotech Ltd., một doanh nghiệp vừa và nhỏ chuyên kinh doanh thiết bị và vật tư công nghiệp.

Dự án được thực hiện trong khuôn khổ học phần **Hệ quản trị cơ sở dữ liệu (FIT4008-D)**.

Mục tiêu là xây dựng một cơ sở dữ liệu tập trung, giúp quản lý thông tin khách hàng, nhân viên, danh mục sản phẩm, đơn hàng và chi tiết đơn hàng; đồng thời hỗ trợ truy vấn và thống kê doanh thu.

### 2. Công nghệ sử dụng

- **Hệ quản trị cơ sở dữ liệu:** Microsoft SQL Server 2025 Developer.
- **Ngôn ngữ truy vấn:** Transact-SQL (T-SQL).
- **Công cụ phát triển:** Visual Studio Code.
- **Tiện ích kết nối:** SQL Server (mssql) Extension.
- **Quản lý mã nguồn:** Git và GitLab.

### 3. Chức năng chính

- Quản lý thông tin khách hàng.
- Quản lý danh mục sản phẩm.
- Quản lý thông tin nhân viên.
- Quản lý đơn hàng.
- Quản lý chi tiết đơn hàng.
- Thực hiện các thao tác thêm, xem, cập nhật và xóa dữ liệu (CRUD).
- Truy vấn dữ liệu bằng JOIN, GROUP BY, HAVING và các hàm tổng hợp.
- Thống kê doanh thu theo tháng và năm.
- Xây dựng các View phục vụ khai thác dữ liệu.
- Sử dụng Index để hỗ trợ tối ưu truy vấn.
- Xây dựng Stored Procedure phục vụ các nghiệp vụ kinh doanh.

### 4. Thiết kế cơ sở dữ liệu

Database: `IsotechSalesDB`

Cơ sở dữ liệu gồm 6 bảng chính:

| STT | Tên bảng | Chức năng |
|---|---|---|
| 1 | Customers | Lưu thông tin khách hàng |
| 2 | Categories | Quản lý danh mục sản phẩm |
| 3 | Employees | Lưu thông tin nhân viên |
| 4 | Products | Quản lý sản phẩm |
| 5 | Orders | Lưu thông tin đơn hàng |
| 6 | OrderDetails | Lưu chi tiết từng sản phẩm trong đơn hàng |

**Các mối quan hệ chính:**

- Categories (1:N) Products.
- Customers (1:N) Orders.
- Employees (1:N) Orders.
- Orders (1:N) OrderDetails.
- Products (1:N) OrderDetails.

Các bảng được liên kết bằng Primary Key và Foreign Key nhằm đảm bảo tính toàn vẹn dữ liệu.

### 5. Các thành phần đã triển khai

**5.1. Database và Tables**

- Tạo database `IsotechSalesDB`.
- Xây dựng 6 bảng dữ liệu.
- Thiết lập Primary Key, Foreign Key, UNIQUE, CHECK và DEFAULT constraints.

**5.2. Sample Data**

- Thêm dữ liệu mẫu cho 6 bảng.
- Kiểm tra dữ liệu và các mối quan hệ giữa các bảng.

**5.3. CRUD Operations**

- INSERT: Thêm dữ liệu.
- SELECT: Truy vấn dữ liệu.
- UPDATE: Cập nhật dữ liệu.
- DELETE: Xóa dữ liệu.

**5.4. Advanced Queries**

- Truy vấn kết hợp nhiều bảng bằng JOIN.
- Thống kê bằng GROUP BY và HAVING.
- Thống kê doanh thu theo tháng và năm.
- Sử dụng các hàm tổng hợp SQL.

**5.5. Views**

- `vw_OrderDetails`: Xem thông tin chi tiết đơn hàng.
- `vw_LowStockProducts`: Theo dõi sản phẩm có số lượng tồn kho thấp.
- `vw_Top5Customers`: Thống kê 5 khách hàng có giá trị đơn hàng cao nhất.

**5.6. Indexes**

- `IX_Customers_Email`: Index hỗ trợ tra cứu khách hàng theo Email.
- `IX_Orders_OrderDate`: Index hỗ trợ truy vấn đơn hàng theo ngày.

**5.7. Stored Procedures**

- `sp_AddNewOrder`: Thêm đơn hàng mới.
- `sp_GetRevenueByDateRange`: Thống kê doanh thu theo khoảng thời gian.
- `sp_GetBestSellingProducts`: Thống kê 5 sản phẩm bán chạy nhất.

### 6. Cấu trúc thư mục dự án

```text
Isotech-Sales-Management/
│
├── README.md
├── .gitignore
│
├── Database/
│   ├── 01_CreateDatabase.sql
│   ├── 02_CreateTables.sql
│   ├── 03_InsertSampleData.sql
│   ├── 04_CRUD.sql
│   ├── 05_AdvancedQueries.sql
│   ├── 06_Views.sql
│   ├── 07_Indexes.sql
│   ├── 08_StoredProcedures.sql
│   └── 09_Testing.sql
│
├── Design/
│   └── ERD.png
│
├── Report/
│
└── Images/
    └── Testing/
```

### 7. Kết quả kiểm thử

Dự án đã thực hiện kiểm thử trên Microsoft SQL Server.

**Dữ liệu hiện có:**

| Bảng | Số bản ghi |
|---|---:|
| Customers | 5 |
| Categories | 3 |
| Employees | 3 |
| Products | 8 |
| Orders | 7 |
| OrderDetails | 10 |
| **Tổng cộng** | **36** |

**Kết quả kiểm thử:**

- Kết nối database thành công.
- Tạo thành công 6 bảng dữ liệu.
- Kiểm tra 5 khóa ngoại.
- Kiểm thử các thao tác CRUD.
- Tạo và kiểm thử 3 Views.
- Tạo 2 Indexes.
- Tạo và thực thi thành công 3 Stored Procedures.
- Kiểm tra tính toàn vẹn các ràng buộc bằng `DBCC CHECKCONSTRAINTS`.

### 8. Hướng dẫn cài đặt và sử dụng

**Yêu cầu môi trường:**

- Microsoft SQL Server.
- Visual Studio Code.
- SQL Server (mssql) Extension.

**Các bước thực hiện:**

1. Clone hoặc tải mã nguồn dự án về máy.
2. Mở thư mục `Isotech-Sales-Management` bằng Visual Studio Code.
3. Kết nối SQL Server bằng tài khoản phù hợp.
4. Mở thư mục `Database`.
5. Thực thi lần lượt các file SQL theo thứ tự từ `01` đến `09`.
6. Kiểm tra kết quả thực thi và dữ liệu trong database `IsotechSalesDB`.

**Lưu ý:** Nếu database đã tồn tại và đã có dữ liệu, cần kiểm tra nội dung từng script trước khi thực thi lại để tránh tạo dữ liệu trùng lặp.

### 9. Kết luận

Dự án Isotech Sales Management đã xây dựng được cơ sở dữ liệu quản lý hoạt động kinh doanh với các thành phần chính gồm bảng dữ liệu, quan hệ, ràng buộc, truy vấn nâng cao, View, Index và Stored Procedure.

Thông qua dự án, người thực hiện có cơ hội vận dụng kiến thức về thiết kế cơ sở dữ liệu quan hệ, ngôn ngữ SQL và khai thác dữ liệu trên Microsoft SQL Server.

---

**Project:** Isotech Sales Management  
**Course:** Hệ quản trị cơ sở dữ liệu (FIT4008-D)  
**Database:** IsotechSalesDB  
**Technology:** Microsoft SQL Server 2025 – T-SQL
