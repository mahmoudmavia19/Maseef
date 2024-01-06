  import 'package:get/get.dart';
import 'package:maseef_app/presentation/admin/add_post_management_screen/add_post_screen.dart';
import 'package:maseef_app/presentation/admin/edit_post_screen/binding/edit_post_binding.dart';
import 'package:maseef_app/presentation/admin/edit_post_screen/edit_post_screen.dart';
import 'package:maseef_app/presentation/admin/show_post_screen/binding/post_manage_binding.dart';
import 'package:maseef_app/presentation/admin/show_post_screen/show_post_screen.dart';

import '../presentation/admin/add_post_management_screen/binding/add_post_binding.dart';
import '../presentation/admin/category_management_screen/binding/category_binding.dart';
import '../presentation/admin/category_management_screen/category_management_screen.dart';
import '../presentation/admin/login_screen/binding/login_binding.dart';
import '../presentation/admin/login_screen/login_screen.dart';
import '../presentation/admin/post_management_screen/binding/post_binding.dart';
import '../presentation/admin/post_management_screen/post_management_screen.dart';


class AppRoutes {
   static const String loginScreen = '/login_screen';
   static const String categoryManagementScreen = '/CategoryManagementScreen';
   static const String postManagementScreen = '/PostManagementScreen';
   static const String showPostScreen = '/ShowPostScreen';
   static const String AddPostManagementScreen = '/AddPostManagementScreen';
   static const String EditPostManagementScreen = '/EditPostManagementScreen';



  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [

    GetPage(
        name: loginScreen,
        page:() => LoginPage() ,
      binding: LoginBinding(),
    ),
    GetPage (
      name: AddPostManagementScreen,
      page: () => AddPostScreen(),
      binding: AddPostBinding(),
    ) ,
    GetPage (
      name: EditPostManagementScreen,
      page: () => EditPostScreen(),
      binding: EditPostBinding(),
    ) ,
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
      arguments: [

      ],
      binding: PostManageBinding(),
    ),
    GetPage(
      name: initialRoute,
      page: () => LoginPage(),
      binding: LoginBinding(),
    )
  ];
}
