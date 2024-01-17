import '../../../../core/app_export.dart';
import '../controller/user_post_controller.dart';

class UserPostManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserPostManageController());
  }
}