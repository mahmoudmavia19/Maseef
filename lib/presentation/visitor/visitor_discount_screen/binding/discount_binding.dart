import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/visitor/visitor_discount_screen/controller/discount_controller.dart';

class DiscountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscountController());
  }
}