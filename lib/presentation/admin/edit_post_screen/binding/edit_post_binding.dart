import '../../../../core/app_export.dart';
import '../controller/edit_post_controller.dart';

class EditPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPostController());
  }
}