import '../../../../core/app_export.dart';
import '../controller/driver_tracking_controller.dart';

class DriverTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverTrackingController());
  }
}