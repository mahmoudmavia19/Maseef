
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';

import '../../../../core/app_export.dart';
import '../../post_management_screen/model/comment.dart';
import '../../post_management_screen/model/post.dart';

class PostManageController extends GetxController {

  PostController postController = Get.find<PostController>();
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
  int index = Get.arguments[0];
  Post post = Get.arguments[1];
  RxList<Comment> comments = RxList<Comment>([]);

  getAllPostComments()async{
    (await remoteDataSource.getAllComments(post.postId!)).fold((l){

    }, (r){
      comments.value = r;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAllPostComments();
  }
  deletePost(int index){
    Get.find<PostController>().deletePost(index);
  }

}