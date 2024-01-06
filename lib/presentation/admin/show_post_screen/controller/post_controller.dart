import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';

import '../../../../core/app_export.dart';

class PostManageController extends GetxController {

  PostController postController = Get.find<PostController>();
  int index = Get.arguments[0];

  deletePost(int index){
    Get.back();
    postController.posts.removeAt(index);
  }



}