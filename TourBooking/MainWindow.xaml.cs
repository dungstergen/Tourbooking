using System.Windows;
using TourBooking.Views;
using TourBooking.Views.Admin;
using TourBooking.ViewModels;
using TourBooking.Services;

namespace TourBooking
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            LoadInterface();
        }

        public void LoadInterface()
        {
            if (SessionService.IsAdmin)
            {
                Title = "TourBooking";
                var adminVM = new AdminDashboardViewModel();
                var adminView = new AdminDashboardView { DataContext = adminVM };
                SwitchView(adminView);
            }
            else
            {
                Title = "TourBooking";
                SwitchView(new DashboardView());
            }
        }

        public void SwitchView(object newView)
        {
            MainContentContainer.Content = newView;
        }
    }
}