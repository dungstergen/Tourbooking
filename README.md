# TourBooking - Hệ thống Quản trị & Điều hành Tour Du lịch

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
  - Tích hợp thanh toán QR Code ngân hàng tự động (VietQR).
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
- **Mô hình kiến trúc:** MVVM (Model - View - ViewModel) kết hợp Repository & Service Pattern
- **Cơ sở dữ liệu & ORM:** SQL Server, Entity Framework 6 (Code First)
- **Thư viện bên thứ ba:**
  - `LiveCharts.Wpf`: Vẽ biểu đồ doanh thu và xu hướng đặt tour.
  - `iTextSharp`: Xuất hóa đơn, vé xác nhận ra file PDF.
  - `QRCoder`: Tạo mã QR Code thanh toán ngân hàng tự động.
  - `MaterialDesignThemes`: Bộ icon và phong cách thiết kế hiện đại.

---

## 🚀 Hướng Dẫn Cài Đặt & Khởi Chạy

### Yêu cầu hệ thống:
- Hệ điều hành: Windows 10/11
- Visual Studio (2019 / 2022 trở lên có workload **.NET desktop development**)
- Microsoft SQL Server / SQL Server Express (2017 trở lên)

### Các bước khởi chạy:
1. **Khởi tạo Cơ sở dữ liệu (Chọn 1 trong 2 cách):**
   - **Cách 1 (Khuyên dùng):** Mở SQL Server Management Studio (SSMS), mở file `Database/TourBookingDB.sql` và bấm **Execute**. Toàn bộ cấu trúc bảng và dữ liệu mẫu đầy đủ sẽ được nạp ngay lập tức.
   - **Cách 2 (Tự động):** Không cần chạy file SQL, Entity Framework sẽ tự động tạo cơ sở dữ liệu `TourBookingDB` và nạp dữ liệu khởi tạo khi bạn bấm chạy ứng dụng lần đầu.
2. **Cấu hình kết nối (Nếu cần):**
   - Mở file `TourBooking/App.config`.
   - Kiểm tra `Data Source` xem đã khớp với tên SQL Server của máy bạn chưa (mặc định là `localhost\SQLEXPRESS` hoặc `.\SQLEXPRESS`).
3. **Mở dự án trong Visual Studio:**
   - Mở file `TourBooking.sln` (tương thích mọi bản Visual Studio) hoặc `TourBooking.slnx`.
   - Chọn cấu hình **Debug | Any CPU**.
   - Bấm **Build** $\rightarrow$ **Rebuild Solution** (`Ctrl + Shift + B`).
4. **Khởi chạy ứng dụng:**
   - Nhấn `F5` hoặc chọn **Start**.

---

## 🔑 Tài Khoản Đăng Nhập Mẫu

| Vai trò | Tên đăng nhập | Mật khẩu | Họ và tên |
| :--- | :--- | :--- | :--- |
| **Quản trị viên (Admin)** | `admin` | `123456` | Nguyễn Tiến Dũng |
| **Quản trị viên 2** | `admin2` | `123456` | Trần Thị Mai |
| **Nhân viên 1 (Staff)** | `nv_nhung` | `123456` | Lê Hồng Nhung |
| **Nhân viên 2 (Staff)** | `nv_tuan` | `123456` | Phạm Minh Tuấn |
| **Nhân viên 3 (Staff)** | `nv_nam` | `123456` | Hoàng Anh Nam |

---

## 👤 Thông Tin Sinh Viên

- **Họ và tên:** Nguyễn Tiến Dũng
- **GitHub Repository:** [https://github.com/dungstergen/Tourbooking.git](https://github.com/dungstergen/Tourbooking.git)
- **Email:** nguyentiendung01062005@gmail.com
- **Đồ án:** TourBooking - Hệ thống Quản trị & Điều hành Tour Du lịch
