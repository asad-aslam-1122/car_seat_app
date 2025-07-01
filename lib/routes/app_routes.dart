import 'package:car_seat/feature/app/base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/add_emergency_contact_page.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/forget_password_pages/change_password_page.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/forget_password_pages/congrajulation_page.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/forget_password_pages/forget_password_page.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/login_page.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/sign_up_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/alerts_and_notification_pages/alert_notification_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/alerts_and_notification_pages/detailed_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/home_pages/home_base_pages.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/manage_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/vehicales_pages/sub_pages/add_vehicle_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/battory_management_section/battery_management_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/biometric_setup_page/bio_metric_set_up_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/customize_theme/customize_theme_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/emergency_contacts/emergency_contact_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/settings/settings_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/settings/sub_pages/update_password_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/sos_pages/sos_dashboard_base_pages.dart';
import 'package:car_seat/feature/user/presentation/pages/landing_pages/splash_page.dart';
import 'package:car_seat/feature/user/presentation/pages/webview_page/webview_page.dart';
import 'package:get/get.dart';

import '../feature/user/presentation/pages/base_pages/manage_pages/sub_categories/device_pages/bluetooth_pages/bluetooth_base_page.dart';
import '../feature/user/presentation/pages/base_pages/manage_pages/sub_categories/device_pages/qr_scan_pages/complete_setup_page.dart';
import '../feature/user/presentation/pages/base_pages/manage_pages/sub_categories/manage_children_pages/sub_pages/add_child_page.dart';
import '../feature/user/presentation/pages/base_pages/profile_pages/profile_base_page.dart';
import '../feature/user/presentation/pages/base_pages/profile_pages/sub_pages/preferences/preferences_page.dart';
import '../feature/user/presentation/pages/landing_pages/onboard_page.dart';
import '../feature/user/presentation/pages/terms_and_privacy_pages/terms_and_conditions.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
        name: OnboardPage.route,
        page: () => const OnboardPage(),
        transition: Transition.circularReveal),
    GetPage(
        name: LoginPage.route,
        page: () => const LoginPage(),
        transition: Transition.fade),
    GetPage(
        name: SignUpPage.route,
        page: () => const SignUpPage(),
        transition: Transition.fade),
    GetPage(
        name: AddEmergencyContactPage.route,
        page: () => const AddEmergencyContactPage(),
        transition: Transition.fade),
    GetPage(
        name: TermsAndConditions.route,
        page: () => const TermsAndConditions(),
        transition: Transition.fade),
    GetPage(
        name: ForgetPasswordPage.route,
        page: () => const ForgetPasswordPage(),
        transition: Transition.fade),
    GetPage(
        name: ChangePasswordPage.route,
        page: () => const ChangePasswordPage(),
        transition: Transition.fade),
    GetPage(
        name: CongrajulationPage.route,
        page: () => const CongrajulationPage(),
        transition: Transition.fade),
    GetPage(
        name: BasePage.route,
        page: () => const BasePage(),
        transition: Transition.fade),
    GetPage(
        name: HomeBasePages.route,
        page: () => const HomeBasePages(),
        transition: Transition.fade),
    GetPage(
        name: AlertNotificationBasePage.route,
        page: () => const AlertNotificationBasePage(),
        transition: Transition.fade),
    GetPage(
        name: AlertDetailedPage.route,
        page: () => const AlertDetailedPage(),
        transition: Transition.fade),
    GetPage(
        name: WebviewPage.route,
        page: () => const WebviewPage(),
        transition: Transition.fade),
    GetPage(
        name: SosDashboardBasePage.route,
        page: () => const SosDashboardBasePage(),
        transition: Transition.fade),
    GetPage(
        name: ManageBasePages.route,
        page: () => const ManageBasePages(),
        transition: Transition.fade),
    GetPage(
        name: CompleteSetupDevice.route,
        page: () => const CompleteSetupDevice(),
        transition: Transition.fade),
    GetPage(
        name: BluetoothBasePage.route,
        page: () => const BluetoothBasePage(),
        transition: Transition.fade),
    GetPage(
        name: AddChildPage.route,
        page: () => const AddChildPage(),
        transition: Transition.fade),
    GetPage(
        name: AddVehiclePage.route,
        page: () => const AddVehiclePage(),
        transition: Transition.fade),
    GetPage(
        name: ProfileBasePage.route,
        page: () => const ProfileBasePage(),
        transition: Transition.fade),
    GetPage(
        name: SettingsBasePage.route,
        page: () => SettingsBasePage(),
        transition: Transition.fade),
    GetPage(
        name: CustomizeThemePage.route,
        page: () => const CustomizeThemePage(),
        transition: Transition.fade),
    GetPage(
        name: PreferencesPage.route,
        page: () => const PreferencesPage(),
        transition: Transition.fade),
    GetPage(
        name: UpdatePasswordPage.route,
        page: () => const UpdatePasswordPage(),
        transition: Transition.fade),
    GetPage(
        name: EmergencyContactBasePages.route,
        page: () => const EmergencyContactBasePages(),
        transition: Transition.fade),
    GetPage(
        name: BioMetricSetUpPage.route,
        page: () => const BioMetricSetUpPage(),
        transition: Transition.fade),
    GetPage(
        name: BatteryManagementBasePage.route,
        page: () => const BatteryManagementBasePage(),
        transition: Transition.fade),
    GetPage(
        name: SplashPage.route,
        page: () => const SplashPage(),
        transition: Transition.fade),
  ];
}
