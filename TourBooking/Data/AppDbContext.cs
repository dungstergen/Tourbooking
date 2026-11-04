using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using TourBooking.Helpers;
using TourBooking.Models;

namespace TourBooking.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext() : base("name=AppDbContext")
        {
            Database.SetInitializer(new AppDbInitializer());
        }

        public DbSet<Tour> Tours { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Staff> Staffs { get; set; }
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<BookingDetail> BookingDetails { get; set; }
        public DbSet<Payment> Payments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }

        public static void EnsureSeedData()
        {
            try
            {
                using (var db = new AppDbContext())
                {
                    string passHash = PasswordHasher.Hash("123456");

                    var sampleStaffs = new List<Staff>
                    {
                        new Staff { StaffCode = "NV01", FullName = "Nguyễn Tiến Dũng", Username = "admin", PasswordHash = passHash, Role = UserRole.Admin, IsActive = true },
                        new Staff { StaffCode = "NV02", FullName = "Trần Thị Mai", Username = "admin2", PasswordHash = passHash, Role = UserRole.Admin, IsActive = true },
                        new Staff { StaffCode = "NV03", FullName = "Lê Hồng Nhung", Username = "nv_nhung", PasswordHash = passHash, Role = UserRole.Staff, IsActive = true },
                        new Staff { StaffCode = "NV04", FullName = "Phạm Minh Tuấn", Username = "nv_tuan", PasswordHash = passHash, Role = UserRole.Staff, IsActive = true },
                        new Staff { StaffCode = "NV05", FullName = "Hoàng Anh Nam", Username = "nv_nam", PasswordHash = passHash, Role = UserRole.Staff, IsActive = true }
                    };

                    bool addedAny = false;
                    foreach (var s in sampleStaffs)
                    {
                        if (!db.Staffs.Any(x => x.Username.ToLower() == s.Username.ToLower()))
                        {
                            db.Staffs.Add(s);
                            addedAny = true;
                        }
                    }

                    if (!db.Tours.Any())
                    {
                        var sampleTours = new List<Tour>
                        {
                            new Tour { TourCode = "T01", TourName = "Hà Nội - Đà Nẵng - Hội An 3N2Đ", Destination = "Đà Nẵng", DepartureDate = DateTime.Now.AddDays(5), ReturnDate = DateTime.Now.AddDays(8), PriceAdult = 3500000, PriceChild = 1750000, TotalSlots = 25, AvailableSlots = 15, IsActive = true },
                            new Tour { TourCode = "T02", TourName = "TP.HCM - Phú Quốc Thiên Đường Đảo Ngọc 4N3Đ", Destination = "Kiên Giang", DepartureDate = DateTime.Now.AddDays(7), ReturnDate = DateTime.Now.AddDays(11), PriceAdult = 5200000, PriceChild = 2600000, TotalSlots = 30, AvailableSlots = 20, IsActive = true },
                            new Tour { TourCode = "T03", TourName = "Hà Nội - Sa Pa - Fansipan Cát Cát 3N2Đ", Destination = "Lào Cai", DepartureDate = DateTime.Now.AddDays(3), ReturnDate = DateTime.Now.AddDays(6), PriceAdult = 2850000, PriceChild = 1400000, TotalSlots = 20, AvailableSlots = 4, IsActive = true },
                            new Tour { TourCode = "T04", TourName = "Đà Nẵng - Bà Nà Hills - Cù Lao Chàm 4N3Đ", Destination = "Đà Nẵng", DepartureDate = DateTime.Now.AddDays(10), ReturnDate = DateTime.Now.AddDays(14), PriceAdult = 4200000, PriceChild = 2100000, TotalSlots = 25, AvailableSlots = 14, IsActive = true },
                            new Tour { TourCode = "T05", TourName = "TP.HCM - Đà Lạt Thành Phố Ngàn Hoa 3N3Đ", Destination = "Lâm Đồng", DepartureDate = DateTime.Now.AddDays(6), ReturnDate = DateTime.Now.AddDays(9), PriceAdult = 2650000, PriceChild = 1325000, TotalSlots = 35, AvailableSlots = 24, IsActive = true },
                            new Tour { TourCode = "T06", TourName = "Hà Nội - Vịnh Hạ Long Du Thuyền 5 Sao 2N1Đ", Destination = "Quảng Ninh", DepartureDate = DateTime.Now.AddDays(2), ReturnDate = DateTime.Now.AddDays(4), PriceAdult = 3900000, PriceChild = 1950000, TotalSlots = 15, AvailableSlots = 0, IsActive = true },
                            new Tour { TourCode = "T07", TourName = "TP.HCM - Cần Thơ Miền Tây Sông Nước 2N1Đ", Destination = "Cần Thơ", DepartureDate = DateTime.Now.AddDays(12), ReturnDate = DateTime.Now.AddDays(14), PriceAdult = 1850000, PriceChild = 950000, TotalSlots = 30, AvailableSlots = 26, IsActive = true },
                            new Tour { TourCode = "T08", TourName = "Hà Nội - Ninh Bình Tràng An Bái Đính 1N", Destination = "Ninh Bình", DepartureDate = DateTime.Now.AddDays(4), ReturnDate = DateTime.Now.AddDays(5), PriceAdult = 950000, PriceChild = 500000, TotalSlots = 40, AvailableSlots = 35, IsActive = true },
                            new Tour { TourCode = "T09", TourName = "Đà Nẵng - Nha Trang Biển Xanh Nắng Vàng 4N3Đ", Destination = "Khánh Hòa", DepartureDate = DateTime.Now.AddDays(15), ReturnDate = DateTime.Now.AddDays(19), PriceAdult = 4600000, PriceChild = 2300000, TotalSlots = 25, AvailableSlots = 18, IsActive = true },
                            new Tour { TourCode = "T10", TourName = "TP.HCM - Quy Nhơn - Phú Yên Hoa Vàng Cỏ Xanh 4N3Đ", Destination = "Bình Định", DepartureDate = DateTime.Now.AddDays(8), ReturnDate = DateTime.Now.AddDays(12), PriceAdult = 4350000, PriceChild = 2175000, TotalSlots = 20, AvailableSlots = 11, IsActive = true }
                        };
                        db.Tours.AddRange(sampleTours);
                        addedAny = true;
                    }

                    if (!db.Customers.Any())
                    {
                        var sampleCustomers = new List<Customer>
                        {
                            new Customer { FullName = "Nguyễn Văn An", Phone = "0912345678", Email = "an.nguyen@gmail.com", NationalId = "001201009876", CreatedAt = DateTime.Now.AddDays(-30) },
                            new Customer { FullName = "Trần Thị Bích Ngọc", Phone = "0987654321", Email = "ngoc.tran@gmail.com", NationalId = "001202008765", CreatedAt = DateTime.Now.AddDays(-25) },
                            new Customer { FullName = "Lê Hoàng Nam", Phone = "0903123456", Email = "nam.le@gmail.com", NationalId = "001200007654", CreatedAt = DateTime.Now.AddDays(-20) },
                            new Customer { FullName = "Phạm Thu Hương", Phone = "0978901234", Email = "huong.pham@gmail.com", NationalId = "001203006543", CreatedAt = DateTime.Now.AddDays(-18) },
                            new Customer { FullName = "Vũ Đình Khoa", Phone = "0934567890", Email = "khoa.vu@gmail.com", NationalId = "001201005432", CreatedAt = DateTime.Now.AddDays(-15) }
                        };
                        db.Customers.AddRange(sampleCustomers);
                        addedAny = true;
                    }

                    if (addedAny)
                    {
                        db.SaveChanges();
                    }
                }
            }
            catch { }
        }
    }

    public class AppDbInitializer : CreateDatabaseIfNotExists<AppDbContext>
    {
        protected override void Seed(AppDbContext context)
        {
            string defaultPasswordHash = PasswordHasher.Hash("123456");

            context.Staffs.Add(new Staff { StaffCode = "NV01", FullName = "Nguyễn Tiến Dũng", Username = "admin", PasswordHash = defaultPasswordHash, Role = UserRole.Admin, IsActive = true });
            context.Staffs.Add(new Staff { StaffCode = "NV02", FullName = "Trần Thị Mai", Username = "admin2", PasswordHash = defaultPasswordHash, Role = UserRole.Admin, IsActive = true });
            context.Staffs.Add(new Staff { StaffCode = "NV03", FullName = "Lê Hồng Nhung", Username = "nv_nhung", PasswordHash = defaultPasswordHash, Role = UserRole.Staff, IsActive = true });
            context.Staffs.Add(new Staff { StaffCode = "NV04", FullName = "Phạm Minh Tuấn", Username = "nv_tuan", PasswordHash = defaultPasswordHash, Role = UserRole.Staff, IsActive = true });
            context.Staffs.Add(new Staff { StaffCode = "NV05", FullName = "Hoàng Anh Nam", Username = "nv_nam", PasswordHash = defaultPasswordHash, Role = UserRole.Staff, IsActive = true });

            var sampleTours = new List<Tour>
            {
                new Tour { TourCode = "T01", TourName = "Hà Nội - Đà Nẵng - Hội An 3N2Đ", Destination = "Đà Nẵng", DepartureDate = DateTime.Now.AddDays(5), ReturnDate = DateTime.Now.AddDays(8), PriceAdult = 3500000, PriceChild = 1750000, TotalSlots = 25, AvailableSlots = 15, IsActive = true },
                new Tour { TourCode = "T02", TourName = "TP.HCM - Phú Quốc Thiên Đường Đảo Ngọc 4N3Đ", Destination = "Kiên Giang", DepartureDate = DateTime.Now.AddDays(7), ReturnDate = DateTime.Now.AddDays(11), PriceAdult = 5200000, PriceChild = 2600000, TotalSlots = 30, AvailableSlots = 20, IsActive = true },
                new Tour { TourCode = "T03", TourName = "Hà Nội - Sa Pa - Fansipan Cát Cát 3N2Đ", Destination = "Lào Cai", DepartureDate = DateTime.Now.AddDays(3), ReturnDate = DateTime.Now.AddDays(6), PriceAdult = 2850000, PriceChild = 1400000, TotalSlots = 20, AvailableSlots = 4, IsActive = true },
                new Tour { TourCode = "T04", TourName = "Đà Nẵng - Bà Nà Hills - Cù Lao Chàm 4N3Đ", Destination = "Đà Nẵng", DepartureDate = DateTime.Now.AddDays(10), ReturnDate = DateTime.Now.AddDays(14), PriceAdult = 4200000, PriceChild = 2100000, TotalSlots = 25, AvailableSlots = 14, IsActive = true },
                new Tour { TourCode = "T05", TourName = "TP.HCM - Đà Lạt Thành Phố Ngàn Hoa 3N3Đ", Destination = "Lâm Đồng", DepartureDate = DateTime.Now.AddDays(6), ReturnDate = DateTime.Now.AddDays(9), PriceAdult = 2650000, PriceChild = 1325000, TotalSlots = 35, AvailableSlots = 24, IsActive = true },
                new Tour { TourCode = "T06", TourName = "Hà Nội - Vịnh Hạ Long Du Thuyền 5 Sao 2N1Đ", Destination = "Quảng Ninh", DepartureDate = DateTime.Now.AddDays(2), ReturnDate = DateTime.Now.AddDays(4), PriceAdult = 3900000, PriceChild = 1950000, TotalSlots = 15, AvailableSlots = 0, IsActive = true },
                new Tour { TourCode = "T07", TourName = "TP.HCM - Cần Thơ Miền Tây Sông Nước 2N1Đ", Destination = "Cần Thơ", DepartureDate = DateTime.Now.AddDays(12), ReturnDate = DateTime.Now.AddDays(14), PriceAdult = 1850000, PriceChild = 950000, TotalSlots = 30, AvailableSlots = 26, IsActive = true },
                new Tour { TourCode = "T08", TourName = "Hà Nội - Ninh Bình Tràng An Bái Đính 1N", Destination = "Ninh Bình", DepartureDate = DateTime.Now.AddDays(4), ReturnDate = DateTime.Now.AddDays(5), PriceAdult = 950000, PriceChild = 500000, TotalSlots = 40, AvailableSlots = 35, IsActive = true },
                new Tour { TourCode = "T09", TourName = "Đà Nẵng - Nha Trang Biển Xanh Nắng Vàng 4N3Đ", Destination = "Khánh Hòa", DepartureDate = DateTime.Now.AddDays(15), ReturnDate = DateTime.Now.AddDays(19), PriceAdult = 4600000, PriceChild = 2300000, TotalSlots = 25, AvailableSlots = 18, IsActive = true },
                new Tour { TourCode = "T10", TourName = "TP.HCM - Quy Nhơn - Phú Yên Hoa Vàng Cỏ Xanh 4N3Đ", Destination = "Bình Định", DepartureDate = DateTime.Now.AddDays(8), ReturnDate = DateTime.Now.AddDays(12), PriceAdult = 4350000, PriceChild = 2175000, TotalSlots = 20, AvailableSlots = 11, IsActive = true }
            };
            context.Tours.AddRange(sampleTours);

            base.Seed(context);
        }
    }
}
