import '../../../../core/app_export.dart';
import '../controller/profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfileController());
  }
}