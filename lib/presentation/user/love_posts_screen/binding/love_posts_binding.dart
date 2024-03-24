import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/user/love_posts_screen/controller/love_posts_controller.dart';

class LovePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LovePostController());
  }
}