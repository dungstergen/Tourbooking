# TourBooking Pro - Hệ thống Quản trị & Điều hành Tour Du lịch

Hệ thống quản lý, điều hành và đặt tour du lịch chuyên nghiệp dành cho doanh nghiệp lữ hành, được xây dựng trên nền tảng WPF (.NET Framework 4.7.2) với kiến trúc MVVM hiện đại.

---

## 🌟 Tính Năng Nổi Bật

### 1. Phân quyền Người dùng (Role-Based Access Control)
- **Quản trị viên (Admin):**
  - Giám sát toàn bộ chỉ số hoạt động kinh doanh, doanh thu, tăng trưởng.
  - Quản lý danh mục chương trình tour: thêm mới, cập nhật lịch trình, giá vé, khóa/kích hoạt tour.
  - Quản lý hồ sơ nhân sự, phân quyền tài khoản vận hành.
  - Quản lý thông tin khách hàng và lịch sử giao dịch.
  - Xuất báo cáo tài chính, thống kê doanh thu sang định dạng CSV/Excel.
- **Nhân viên (Staff):**
  - Tra cứu nhanh thông tin tour, lịch trình và số chỗ còn trống.
  - Tạo đơn đặt tour cho khách hàng với quy trình tối ưu hóa.
  - Quản lý đơn hàng, cập nhật trạng thái đơn (Đã thanh toán, Đã hủy, Hoàn tiền).
  - Tích hợp thanh toán QR Code ngân hàng tự động.
  - Xuất vé / hóa đơn xác nhận đặt tour định dạng PDF.
  - Theo dõi hiệu suất cá nhân và doanh số đạt được theo tháng.

### 2. Giao diện & Trải nghiệm Người dùng (UI/UX)
- Thiết kế hiện đại theo phong cách **Emerald & Teal Theme** đặc trưng của ngành du lịch.
- Trực quan hóa dữ liệu với biểu đồ động **LiveCharts**.
- Điều hướng mượt mà, phân loại trạng thái bằng màu sắc trực quan.
- Tự động kiểm tra tính hợp lệ dữ liệu nhập (Validation).

---

## 🛠 Công Nghệ Sử Dụng

- **Ngôn ngữ & Nền tảng:** C# (.NET Framework 4.7.2)
- **Công nghệ giao diện:** WPF (Windows Presentation Foundation), XAML
- **Mô hình kiến trúc:** MVVM (Model - View - ViewModel)
- **Cơ sở dữ liệu & ORM:** SQL Server, Entity Framework 6 (Code First / DbFirst)
- **Thư viện bên thứ ba:**
  - `LiveCharts.Wpf`: Vẽ biểu đồ doanh thu và xu hướng đặt tour.
  - `iTextSharp`: Xuất hóa đơn, vé xác nhận ra file PDF.
  - `QRCoder`: Tạo mã QR Code thanh toán ngân hàng tự động.
  - `MaterialDesignThemes`: Bộ icon và phong cách thiết kế hiện đại.

---

## 🚀 Hướng Dẫn Cài Đặt & Khởi Chạy

### Yêu cầu hệ thống:
- Hệ điều hành: Windows 10/11
- Visual Studio 2022 trở lên (có cài đặt workload **.NET desktop development**)
- Microsoft SQL Server / SQL Server Express (2019 trở lên)

### Các bước cài đặt:
1. **Clone repository:**
   ```bash
   git clone https://github.com/dungstergen/Tourbooking.git
   ```
2. **Cấu hình chuỗi kết nối cơ sở dữ liệu:**
   - Mở file `TourBooking/App.config`.
   - Cập nhật chuỗi kết nối `AppDbContext` phù hợp với máy của bạn:
     ```xml
     <connectionStrings>
         <add name="AppDbContext"
              connectionString="Data Source=localhost\SQLEXPRESS;Initial Catalog=TourBookingDB;Integrated Security=True"
              providerName="System.Data.SqlClient" />
     </connectionStrings>
     ```
3. **Mở giải pháp trong Visual Studio:**
   - Mở file `TourBooking.slnx` hoặc `TourBooking/TourBooking.csproj`.
   - Build Solution (`Ctrl + Shift + B`).
4. **Khởi chạy ứng dụng:**
   - Nhấn `F5` hoặc chọn **Start Debugging** trong Visual Studio.

---

## 👤 Tác Giả

- **Họ và tên:** Nguyễn Tiến Dũng
- **GitHub:** [@dungstergen](https://github.com/dungstergen)
- **Email:** nguyentiendung01062005@gmail.com
- **Dự án:** TourBooking Pro - Báo cáo Đồ án cuối kỳ
