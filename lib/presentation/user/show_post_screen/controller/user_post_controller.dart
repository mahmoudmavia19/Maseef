import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';

import '../../../../core/app_export.dart';

class UserPostManageController extends GetxController {

   int index = Get.arguments[0];
   Post post = Get.arguments[1];

  deletePost(int index){
     Get.back();
  }

}