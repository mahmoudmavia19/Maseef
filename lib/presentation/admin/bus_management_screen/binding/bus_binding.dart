import '../../../../core/app_export.dart';
import '../controller/bus_controller.dart';

class BusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusController());
  }
}