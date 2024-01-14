import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/user/home_screen/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}