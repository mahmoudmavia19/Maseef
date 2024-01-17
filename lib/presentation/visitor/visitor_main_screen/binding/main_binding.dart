
import '../../../../core/app_export.dart';
import '../controller/main_controller.dart';

class GuestMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestMainController());
   }
}