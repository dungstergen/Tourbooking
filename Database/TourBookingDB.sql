-- ==========================================================
-- HỆ THỐNG QUẢN TRỊ & ĐIỀU HÀNH TOUR DU LỊCH (TOURBOOKING)
-- Tác giả: Nguyễn Tiến Dũng
-- Database: TourBookingDB
-- ==========================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'TourBookingDB')
BEGIN
    CREATE DATABASE TourBookingDB;
END
GO

USE TourBookingDB;
GO

-- XÓA BẢNG NẾU ĐÃ TỒN TẠI (THEO THỨ TỰ RÀNG BUỘC KHÓA NGOẠI)
IF OBJECT_ID(N'dbo.Payments', 'U') IS NOT NULL DROP TABLE dbo.Payments;
IF OBJECT_ID(N'dbo.BookingDetails', 'U') IS NOT NULL DROP TABLE dbo.BookingDetails;
IF OBJECT_ID(N'dbo.Bookings', 'U') IS NOT NULL DROP TABLE dbo.Bookings;
IF OBJECT_ID(N'dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
IF OBJECT_ID(N'dbo.Tours', 'U') IS NOT NULL DROP TABLE dbo.Tours;
IF OBJECT_ID(N'dbo.Staffs', 'U') IS NOT NULL DROP TABLE dbo.Staffs;
GO

-- 1. BẢNG NHÂN VIÊN & TÀI KHOẢN (STAFFS)
CREATE TABLE dbo.Staffs (
    StaffId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StaffCode NVARCHAR(50) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    Role INT NOT NULL, -- 0: Staff, 1: Admin
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- 2. BẢNG CHƯƠNG TRÌNH TOUR (TOURS)
CREATE TABLE dbo.Tours (
    TourId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TourCode NVARCHAR(50) NOT NULL,
    TourName NVARCHAR(200) NOT NULL,
    Destination NVARCHAR(100) NOT NULL,
    DepartureDate DATETIME NOT NULL,
    ReturnDate DATETIME NOT NULL,
    PriceAdult DECIMAL(18,2) NOT NULL,
    PriceChild DECIMAL(18,2) NOT NULL,
    TotalSlots INT NOT NULL,
    AvailableSlots INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- 3. BẢNG KHÁCH HÀNG (CUSTOMERS)
CREATE TABLE dbo.Customers (
    CustomerId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) NULL,
    NationalId NVARCHAR(20) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- 4. BẢNG ĐƠN ĐẶT CHỖ (BOOKINGS)
CREATE TABLE dbo.Bookings (
    BookingId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BookingCode NVARCHAR(50) NOT NULL,
    TourId INT NOT NULL,
    CustomerId INT NOT NULL,
    StaffId INT NOT NULL,
    Status INT NOT NULL, -- 0: Pending, 1: Paid, 2: Cancelled, 3: Refunded
    TotalAmount DECIMAL(18,2) NOT NULL,
    BookingDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Bookings_Tours FOREIGN KEY (TourId) REFERENCES dbo.Tours (TourId),
    CONSTRAINT FK_Bookings_Customers FOREIGN KEY (CustomerId) REFERENCES dbo.Customers (CustomerId),
    CONSTRAINT FK_Bookings_Staffs FOREIGN KEY (StaffId) REFERENCES dbo.Staffs (StaffId)
);
GO

-- 5. BẢNG CHI TIẾT ĐẶT VÉ (BOOKINGDETAILS)
CREATE TABLE dbo.BookingDetails (
    DetailId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BookingId INT NOT NULL,
    PassengerType INT NOT NULL, -- 0: Adult, 1: Child
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_BookingDetails_Bookings FOREIGN KEY (BookingId) REFERENCES dbo.Bookings (BookingId) ON DELETE CASCADE
);
GO

-- 6. BẢNG LỊCH SỬ THANH TOÁN (PAYMENTS)
CREATE TABLE dbo.Payments (
    PaymentId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BookingId INT NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Method INT NOT NULL, -- 0: Cash, 1: Transfer
    PaidAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Bookings FOREIGN KEY (BookingId) REFERENCES dbo.Bookings (BookingId) ON DELETE CASCADE
);
GO

-- ==========================================================
-- NẠP DỮ LIỆU MẪU (SEED DATA)
-- ==========================================================

-- 1. Nạp Staffs (Mật khẩu mặc định: 123456)
SET IDENTITY_INSERT dbo.Staffs ON;
INSERT INTO dbo.Staffs (StaffId, StaffCode, FullName, Username, PasswordHash, Role, IsActive)
VALUES
(1, N'NV01', N'Nguyễn Tiến Dũng', N'admin', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 1),
(2, N'NV02', N'Trần Thị Mai', N'admin2', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, 1),
(3, N'NV03', N'Lê Hồng Nhung', N'nv_nhung', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 0, 1),
(4, N'NV04', N'Phạm Minh Tuấn', N'nv_tuan', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 0, 1),
(5, N'NV05', N'Hoàng Anh Nam', N'nv_nam', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 0, 1);
SET IDENTITY_INSERT dbo.Staffs OFF;
GO

-- 2. Nạp Tours
SET IDENTITY_INSERT dbo.Tours ON;
INSERT INTO dbo.Tours (TourId, TourCode, TourName, Destination, DepartureDate, ReturnDate, PriceAdult, PriceChild, TotalSlots, AvailableSlots, IsActive)
VALUES
(1, N'T01', N'Hà Nội - Đà Nẵng - Hội An 3N2Đ', N'Đà Nẵng', DATEADD(day, 5, GETDATE()), DATEADD(day, 8, GETDATE()), 3500000, 1750000, 25, 15, 1),
(2, N'T02', N'TP.HCM - Phú Quốc Thiên Đường Đảo Ngọc 4N3Đ', N'Kiên Giang', DATEADD(day, 7, GETDATE()), DATEADD(day, 11, GETDATE()), 5200000, 2600000, 30, 20, 1),
(3, N'T03', N'Hà Nội - Sa Pa - Fansipan Cát Cát 3N2Đ', N'Lào Cai', DATEADD(day, 3, GETDATE()), DATEADD(day, 6, GETDATE()), 2850000, 1400000, 20, 4, 1),
(4, N'T04', N'Đà Nẵng - Bà Nà Hills - Cù Lao Chàm 4N3Đ', N'Đà Nẵng', DATEADD(day, 10, GETDATE()), DATEADD(day, 14, GETDATE()), 4200000, 2100000, 25, 14, 1),
(5, N'T05', N'TP.HCM - Đà Lạt Thành Phố Ngàn Hoa 3N3Đ', N'Lâm Đồng', DATEADD(day, 6, GETDATE()), DATEADD(day, 9, GETDATE()), 2650000, 1325000, 35, 24, 1),
(6, N'T06', N'Hà Nội - Vịnh Hạ Long Du Thuyền 5 Sao 2N1Đ', N'Quảng Ninh', DATEADD(day, 2, GETDATE()), DATEADD(day, 4, GETDATE()), 3900000, 1950000, 15, 0, 1),
(7, N'T07', N'TP.HCM - Cần Thơ Miền Tây Sông Nước 2N1Đ', N'Cần Thơ', DATEADD(day, 12, GETDATE()), DATEADD(day, 14, GETDATE()), 1850000, 950000, 30, 26, 1),
(8, N'T08', N'Hà Nội - Ninh Bình Tràng An Bái Đính 1N', N'Ninh Bình', DATEADD(day, 4, GETDATE()), DATEADD(day, 5, GETDATE()), 950000, 500000, 40, 35, 1),
(9, N'T09', N'Đà Nẵng - Nha Trang Biển Xanh Nắng Vàng 4N3Đ', N'Khánh Hòa', DATEADD(day, 15, GETDATE()), DATEADD(day, 19, GETDATE()), 4600000, 2300000, 25, 18, 1),
(10, N'T10', N'TP.HCM - Quy Nhơn - Phú Yên Hoa Vàng Cỏ Xanh 4N3Đ', N'Bình Định', DATEADD(day, 8, GETDATE()), DATEADD(day, 12, GETDATE()), 4350000, 2175000, 20, 11, 1);
SET IDENTITY_INSERT dbo.Tours OFF;
GO

-- 3. Nạp Customers
SET IDENTITY_INSERT dbo.Customers ON;
INSERT INTO dbo.Customers (CustomerId, FullName, Phone, Email, NationalId, CreatedAt)
VALUES
(1, N'Nguyễn Văn An', N'0912345678', N'an.nguyen@gmail.com', N'001201009876', DATEADD(day, -30, GETDATE())),
(2, N'Trần Thị Bích Ngọc', N'0987654321', N'ngoc.tran@gmail.com', N'001202008765', DATEADD(day, -25, GETDATE())),
(3, N'Lê Hoàng Nam', N'0903123456', N'nam.le@gmail.com', N'001200007654', DATEADD(day, -20, GETDATE())),
(4, N'Phạm Thu Hương', N'0978901234', N'huong.pham@gmail.com', N'001203006543', DATEADD(day, -18, GETDATE())),
(5, N'Vũ Đình Khoa', N'0934567890', N'khoa.vu@gmail.com', N'001201005432', DATEADD(day, -15, GETDATE())),
(6, N'Đặng Mai Phương', N'0918765432', N'phuong.dang@gmail.com', N'001202004321', DATEADD(day, -12, GETDATE())),
(7, N'Bùi Thanh Tùng', N'0945678901', N'tung.bui@gmail.com', N'001200003210', DATEADD(day, -10, GETDATE())),
(8, N'Đỗ Mỹ Linh', N'0967890123', N'linh.do@gmail.com', N'001203002109', DATEADD(day, -8, GETDATE())),
(9, N'Hoàng Gia Bảo', N'0923456789', N'bao.hoang@gmail.com', N'001201001098', DATEADD(day, -5, GETDATE())),
(10, N'Ngô Quỳnh Trang', N'0981234567', N'trang.ngo@gmail.com', N'001202000987', DATEADD(day, -2, GETDATE()));
SET IDENTITY_INSERT dbo.Customers OFF;
GO

-- 4. Nạp Bookings
SET IDENTITY_INSERT dbo.Bookings ON;
INSERT INTO dbo.Bookings (BookingId, BookingCode, TourId, CustomerId, StaffId, Status, TotalAmount, BookingDate)
VALUES
(1, N'BK26001', 1, 1, 1, 1, 7000000, DATEADD(hour, -2, GETDATE())),
(2, N'BK26002', 2, 2, 3, 1, 10400000, DATEADD(hour, -5, GETDATE())),
(3, N'BK26003', 3, 3, 3, 1, 7100000, DATEADD(day, -1, GETDATE())),
(4, N'BK26004', 4, 4, 4, 0, 4200000, DATEADD(day, -1, GETDATE())),
(5, N'BK26005', 5, 5, 4, 1, 5300000, DATEADD(day, -2, GETDATE())),
(6, N'BK26006', 6, 6, 5, 1, 7800000, DATEADD(day, -2, GETDATE())),
(7, N'BK26007', 7, 7, 3, 1, 3700000, DATEADD(day, -3, GETDATE())),
(8, N'BK26008', 8, 8, 4, 2, 1900000, DATEADD(day, -4, GETDATE())),
(9, N'BK26009', 9, 9, 1, 1, 9200000, DATEADD(day, -5, GETDATE())),
(10, N'BK26010', 10, 10, 5, 1, 6525000, DATEADD(day, -6, GETDATE())),
(11, N'BK26011', 1, 2, 3, 0, 3500000, DATEADD(hour, -1, GETDATE())),
(12, N'BK26012', 2, 5, 5, 3, 5200000, DATEADD(day, -8, GETDATE()));
SET IDENTITY_INSERT dbo.Bookings OFF;
GO

-- 5. Nạp BookingDetails
SET IDENTITY_INSERT dbo.BookingDetails ON;
INSERT INTO dbo.BookingDetails (DetailId, BookingId, PassengerType, Quantity, UnitPrice)
VALUES
(1, 1, 0, 2, 3500000),
(2, 2, 0, 2, 5200000),
(3, 3, 0, 2, 2850000),
(4, 3, 1, 1, 1400000),
(5, 4, 0, 1, 4200000),
(6, 5, 0, 2, 2650000),
(7, 6, 0, 2, 3900000),
(8, 7, 0, 2, 1850000),
(9, 8, 0, 2, 950000),
(10, 9, 0, 2, 4600000),
(11, 10, 0, 1, 4350000),
(12, 10, 1, 1, 2175000),
(13, 11, 0, 1, 3500000),
(14, 12, 0, 1, 5200000);
SET IDENTITY_INSERT dbo.BookingDetails OFF;
GO

-- 6. Nạp Payments
SET IDENTITY_INSERT dbo.Payments ON;
INSERT INTO dbo.Payments (PaymentId, BookingId, Amount, Method, PaidAt)
VALUES
(1, 1, 7000000, 1, DATEADD(hour, -2, GETDATE())),
(2, 2, 10400000, 1, DATEADD(hour, -5, GETDATE())),
(3, 3, 7100000, 0, DATEADD(day, -1, GETDATE())),
(4, 5, 5300000, 1, DATEADD(day, -2, GETDATE())),
(5, 6, 7800000, 1, DATEADD(day, -2, GETDATE())),
(6, 7, 3700000, 0, DATEADD(day, -3, GETDATE())),
(7, 9, 9200000, 1, DATEADD(day, -5, GETDATE())),
(8, 10, 6525000, 1, DATEADD(day, -6, GETDATE())),
(9, 12, 5200000, 1, DATEADD(day, -8, GETDATE()));
SET IDENTITY_INSERT dbo.Payments OFF;
GO

PRINT '==================================================';
PRINT 'KHOI TAO CSDL TOURBOOKING THANH CONG 100%!';
PRINT '==================================================';