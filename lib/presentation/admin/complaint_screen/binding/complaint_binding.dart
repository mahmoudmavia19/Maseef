
import '../../../../core/app_export.dart';
import '../controller/complaint_controller.dart';

class ComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ComplaintController());
  }
}