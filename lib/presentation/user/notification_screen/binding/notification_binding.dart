import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/user/notification_screen/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}