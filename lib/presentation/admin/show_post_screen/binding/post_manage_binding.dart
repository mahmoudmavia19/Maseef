import '../../../../core/app_export.dart';
import '../controller/post_controller.dart';

class PostManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostManageController());
  }
}