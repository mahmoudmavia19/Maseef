import '../../../../core/app_export.dart';
import '../controller/add_post_controller.dart';

class AddPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPostController());
  }
}