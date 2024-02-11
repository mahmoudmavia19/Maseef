import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';

import '../../../../core/app_export.dart';

class PostManageController extends GetxController {

  PostController postController = Get.find<PostController>();
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
  int index = Get.arguments[0];

  deletePost(int index){
    Get.find<PostController>().deletePost(index);
  }

}