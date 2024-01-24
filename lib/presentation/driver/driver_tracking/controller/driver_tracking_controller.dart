import '../../../../core/app_export.dart';

class DriverTrackingController extends GetxController {
  RxBool startTracking = false.obs;

  trackingToggle() {
    startTracking.value = !startTracking.value;
  }


}