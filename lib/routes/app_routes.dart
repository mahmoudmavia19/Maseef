import 'package:get/get.dart';
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
  static const String loginScreen = '/login_screen';
  static const String categoryManagementScreen = '/CategoryManagementScreen';
  static const String postManagementScreen = '/PostManagementScreen';
  static const String showPostScreen = '/ShowPostScreen';
  static const String AddPostManagementScreen = '/AddPostManagementScreen';
  static const String EditPostManagementScreen = '/EditPostManagementScreen';
  static const String addBusScreen = '/addBusScreen';
  static const String editBusScreen = '/editBusScreen';
  static const String busDetailsScreen = '/BusDetailsScreen';
  static const String busManagementScreen = '/BusManagementScreen';
  static const String complaintScreen = '/complaintScreen';
  static const String driverManagementScreen = '/driverManagementScreen';
  static const String storeManagement = '/storeManagement';
  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: loginScreen,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AddPostManagementScreen,
      page: () => AddPostScreen(),
      binding: AddPostBinding(),
    ),
    GetPage(
      name: EditPostManagementScreen,
      page: () => EditPostScreen(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: categoryManagementScreen,
      page: () => CategoryManagementScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: postManagementScreen,
      page: () => PostManagementScreen(),
      binding: PostBinding(),
    ),
    GetPage(
      name: showPostScreen,
      page: () => ShowPostScreen(),
      arguments: [],
      binding: PostManageBinding(),
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: busManagementScreen,
      page: () => BusManagementScreen(),
      binding: BusBinding(),
    ),
    GetPage(
      name: addBusScreen,
      page: () => AddEditBusScreen(),
    ),
    GetPage(
      name: editBusScreen,
      page: () => AddEditBusScreen(isEdit: true,),
    ),
    GetPage(
      name: busDetailsScreen,
      page: () => BusDetailsScreen(),
    ),
    GetPage(
      name: complaintScreen,
      page: () => ComplaintsManagementScreen(),
      binding: ComplaintBinding(),
    ),
    GetPage(
      name: driverManagementScreen,
      page: () => DriversManagementScreen(),
      binding: DriverBinding(),
    ),
    GetPage(
      name: storeManagement,
      page: () => StoreManagementScreen(),
      binding: StoreBinding(),
    ),
  ];
}
