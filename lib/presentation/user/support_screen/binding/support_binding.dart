
import '../../../../core/app_export.dart';
import '../controller/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ComplaintController());
  }
}