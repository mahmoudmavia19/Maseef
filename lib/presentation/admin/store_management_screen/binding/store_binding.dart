import '../../../../core/app_export.dart';
import '../controller/store_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController());
  }
}