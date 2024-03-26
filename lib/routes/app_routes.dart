import 'package:get/get.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/presentation/driver/driver_tracking/binding/driver_tracking_binding.dart';
import 'package:maseef_app/presentation/driver/driver_tracking/driver_tracking_screen.dart';
import 'package:maseef_app/presentation/driver/login/binding/driver_login_binding.dart';
import 'package:maseef_app/presentation/driver/login/controller/driver_controller.dart';
import 'package:maseef_app/presentation/splach_screen/splach_screen.dart';
import 'package:maseef_app/presentation/user/auth/binding/auth_binding.dart';
import 'package:maseef_app/presentation/user/auth/login.dart';
import 'package:maseef_app/presentation/user/auth/register.dart';
import 'package:maseef_app/presentation/user/home_screen/binding/home_binding.dart';
import 'package:maseef_app/presentation/user/love_posts_screen/binding/love_posts_binding.dart';
import 'package:maseef_app/presentation/user/notification_screen/binding/notification_binding.dart';
import 'package:maseef_app/presentation/user/profile_screen/binding/profile_binding.dart';
import 'package:maseef_app/presentation/user/profile_screen/profile_screen.dart';
import 'package:maseef_app/presentation/user/support_screen/binding/support_binding.dart';
import 'package:maseef_app/presentation/user/support_screen/support_screen.dart';
import 'package:maseef_app/presentation/user/another_screens/privacy_policy.dart';
import 'package:maseef_app/presentation/user/auth/binding/auth_binding.dart';
import 'package:maseef_app/presentation/user/auth/login.dart';
import 'package:maseef_app/presentation/user/auth/register.dart';
import 'package:maseef_app/presentation/user/locations_screen/binding/location_binding.dart';
import 'package:maseef_app/presentation/user/profile_screen/binding/profile_binding.dart';
import 'package:maseef_app/presentation/user/profile_screen/profile_screen.dart';
import 'package:maseef_app/presentation/user/support_screen/binding/support_binding.dart';
import 'package:maseef_app/presentation/user/support_screen/support_screen.dart';
import 'package:maseef_app/presentation/visitor/visitor_discount_screen/binding/discount_binding.dart';
import 'package:maseef_app/presentation/visitor/visitor_home_screen/binding/home_binding.dart';
import '../presentation/admin/add_post_management_screen/binding/add_post_binding.dart';
import '../presentation/admin/add_post_management_screen/add_post_screen.dart';
import '../presentation/admin/bus_management_screen/add_edit_bus_screen.dart';
import '../presentation/admin/bus_management_screen/binding/bus_binding.dart';
import '../presentation/admin/bus_management_screen/bus_details_screen.dart';
import '../presentation/admin/bus_management_screen/bus_management_screen.dart';
import '../presentation/admin/category_management_screen/binding/category_binding.dart';
import '../presentation/admin/category_management_screen/category_management_screen.dart';
import '../presentation/admin/complaint_screen/binding/complaint_binding.dart';
import '../presentation/admin/complaint_screen/complaint_screen.dart';
import '../presentation/admin/drivers_management/binding/driver_binding.dart';
import '../presentation/admin/drivers_management/drivers_management_screen.dart';
import '../presentation/admin/edit_post_screen/binding/edit_post_binding.dart';
import '../presentation/admin/edit_post_screen/edit_post_screen.dart';
import '../presentation/admin/login_screen/binding/login_binding.dart';
import '../presentation/admin/login_screen/login_screen.dart';
import '../presentation/admin/post_management_screen/binding/post_binding.dart';
import '../presentation/admin/post_management_screen/post_management_screen.dart';
import '../presentation/admin/show_post_screen/binding/post_manage_binding.dart';
import '../presentation/admin/show_post_screen/show_post_screen.dart';
import '../presentation/admin/store_management_screen/binding/store_binding.dart';
import '../presentation/admin/store_management_screen/store_management_screen.dart';
import '../presentation/driver/login/driver_login_screen.dart';
import '../presentation/navigation/choose_user_screen.dart';
import '../presentation/user/another_screens/terms_conditions.dart';
import '../presentation/user/auth/forget_password.dart';
import '../presentation/user/auth/forget_password_code_screen.dart';
import '../presentation/user/auth/new_password_screen.dart';
import '../presentation/user/auth/user_login_register_screen.dart';
import '../presentation/user/main_screen/binding/main_binding.dart';
import '../presentation/user/main_screen/main_screen.dart';
import '../presentation/user/show_post_screen/binding/user_post_manage_binding.dart';
import '../presentation/user/show_post_screen/user_show_post_screen.dart';
import '../presentation/visitor/visitor_main_screen/binding/main_binding.dart';
import '../presentation/visitor/visitor_main_screen/main_screen.dart';


class AppRoutes {
  static const String adminLoginScreen = '/Admin/login_screen';
  static const String adminCategoryManagementScreen = '/Admin/CategoryManagementScreen';
  static const String adminPostManagementScreen = '/Admin/PostManagementScreen';
  static const String adminShowPostScreen = '/Admin/ShowPostScreen';
  static const String adminAddPostManagementScreen = '/Admin/AddPostManagementScreen';
  static const String adminEditPostManagementScreen = '/Admin/EditPostManagementScreen';
  static const String adminAddBusScreen = '/Admin/addBusScreen';
  static const String adminEditBusScreen = '/Admin/editBusScreen';
  static const String adminBusDetailsScreen = '/Admin/BusDetailsScreen';
  static const String adminBusManagementScreen = '/Admin/BusManagementScreen';
  static const String adminComplaintScreen = '/Admin/complaintScreen';
  static const String adminDriverManagementScreen = '/Admin/driverManagementScreen';
  static const String adminStoreManagement = '/Admin/storeManagement';
  // User Routes
  static const String userLoginScreen = '/user/login_screen';
  static const String userRegisterScreen = '/user/register_screen';
  static const String userForgetPasswordScreen = '/user/forget_password_screen';
  static const String userForgetPasswordCodeScreen = '/user/forget_password_code_screen';
  static const String userNewPasswordCodeScreen = '/user/new_password_code_screen';
  static const String userLoginOrRegisterScreen = '/user/login_or_register_screen';
  static const String userMainScreen = '/user/main_screen';
  static const String userProfileScreen = '/user/profile_screen';
  static const String userShowPostScreen = '/user/show_post_screen';
  static const String userComplaintScreen = '/user/complaint_screen';
  static const String userPrivacyPolicyScreen = '/user/privacy_policy_screen';
  static const String userTermsAndConditionsScreen = '/user/terms_and_conditions_screen';
  static const String driverLoginScreen = '/driver/login_screen';
  static const String driverTrackingScreen = '/driver/tracking_screen';


  // Visitor Routes
  static const String guestMainScreen = '/guest/main_screen';



  static const String initialRoute = '/initialRoute';
  static const String chooseUser  = '/chooseUser';

  static List<GetPage> pages = [
    GetPage(
      name: adminLoginScreen,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: adminAddPostManagementScreen,
      page: () => AddPostScreen(),
      binding: AddPostBinding(),
    ),
    GetPage(
      name: adminEditPostManagementScreen,
      page: () => EditPostScreen(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: adminCategoryManagementScreen,
      page: () => CategoryManagementScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: adminPostManagementScreen,
      page: () => PostManagementScreen(),
      binding: PostBinding(),
    ),
    GetPage(
      name: adminShowPostScreen,
      page: () => ShowPostScreen(),
      arguments: [],
      binding: PostManageBinding(),
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: chooseUser,
      page: () => ChooseUserScreen(),
    ),
    GetPage(
      name: adminBusManagementScreen,
      page: () => BusManagementScreen(),
      binding: BusBinding(),
    ),
    GetPage(
      name: adminAddBusScreen,
      page: () => AddEditBusScreen(),
    ),
    GetPage(
      name: adminEditBusScreen,
      page: () => AddEditBusScreen(isEdit: true,),
    ),
    GetPage(
      name: adminBusDetailsScreen,
      page: () => BusDetailsScreen(),
    ),
    GetPage(
      name: adminComplaintScreen,
      page: () => ComplaintsManagementScreen(),
      binding: ComplaintBinding(),
    ),
    GetPage(
      name: adminDriverManagementScreen,
      page: () => DriversManagementScreen(),
      binding: DriverBinding(),
    ),
    GetPage(
      name: adminStoreManagement,
      page: () => StoreManagementScreen(),
      binding: StoreBinding(),
    ),
    // User Routes
    GetPage (
      name: userLoginScreen,
      page: () => UserLoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: userLoginOrRegisterScreen,
      page: () => UserLoginOrRegister(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: userRegisterScreen,
      page: () => UserRegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage (
      name: userForgetPasswordScreen,
      page: () => UserForgetPasswordPage(),
    ),
    GetPage(
      name: userForgetPasswordCodeScreen,
      page: () => UserForgetPasswordCodePage(),
    ),
    GetPage(
      name: userNewPasswordCodeScreen,
      page: () => UserNewPasswordCodePage(),
    ),
    GetPage(
      name: userMainScreen,
      page: () =>  MainScreen(),
      bindings: [
        MainBinding() ,
        LocationBinding() ,
        HomeBinding() ,
        LovePostBinding(),
        NotificationBinding(),
        UserProfileBinding(),
      ],
    ),
    GetPage(
      name: userProfileScreen,
      page: () =>  UserProfileScreen(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: userShowPostScreen,
      page: () =>  UserShowPostScreen(),
      binding: UserPostManageBinding(),
    ),
    GetPage(
      name: userComplaintScreen,
      page: () =>  SupportScreen(),
      binding: SupportBinding(),
    ),
    // Visitor Routes
    GetPage(
      name: guestMainScreen,
      page: () =>  GuestMainScreen(),
      bindings:[
        GuestMainBinding(),
        GuestHomeBinding(),
        DiscountBinding(),
        LocationBinding()
      ],
    ),
    GetPage(
      name: userPrivacyPolicyScreen,
      page: () =>  PrivacyPolicy()
    ),
    GetPage(
      name: userTermsAndConditionsScreen,
      page: () =>  TermsAndConditions()
    ),
    // Driver Routes
    GetPage (
      name: driverLoginScreen,
      page: () =>  DriverLoginPage(),
      binding: DriverLoginBinding(),
    ),
    GetPage(
      name: driverTrackingScreen,
      page: () =>  DriverTracking(),
      binding: DriverTrackingBinding(),
    ),

  ];
}
