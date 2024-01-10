import '../../../../core/app_export.dart';
import '../controller/driver_controller.dart';

class DriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverController());
  }
}