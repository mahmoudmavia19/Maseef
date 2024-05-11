
import 'package:get/get.dart';
import 'package:maseef_app/presentation/admin/block_users/controller/block_users_controller.dart';

class BlockUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlockUsersController());
  }
}