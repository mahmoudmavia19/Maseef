import '../../../../core/app_export.dart';
import '../controller/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController());
  }
}