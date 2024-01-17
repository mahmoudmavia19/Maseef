import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';

import '../../../../core/app_export.dart';
import '../controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => PostController());
  }
}