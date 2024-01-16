import 'package:get/get.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/presentation/splach_screen/splach_screen.dart';
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
  static const String initialRoute = '/initialRoute';

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
      name: AppRoutes.adminEditPostManagementScreen,
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
      name: AppStrings.storeManagement,
      page: () => StoreManagementScreen(),
      binding: StoreBinding(),
    ),
  ];
}
