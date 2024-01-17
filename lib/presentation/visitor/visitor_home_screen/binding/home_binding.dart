import 'package:maseef_app/core/app_export.dart';

import '../controller/home_controller.dart';

class GuestHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestHomeController());
  }
}