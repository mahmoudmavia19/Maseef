
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../post_management_screen/model/comment.dart';
import '../../post_management_screen/model/post.dart';

class PostManageController extends GetxController {

  PostController postController = Get.find<PostController>();
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
  int index = Get.arguments[0];
  Post post = Get.arguments[1];
  RxList<Comment> comments = RxList<Comment>([]);
  Rx<FlowState> stateComment = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));

  getAllPostComments()async{
    stateComment.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getAllComments(post.postId!)).fold((l){
      stateComment.value = ErrorState(StateRendererType.popupErrorState, l.message);
    }, (r){
      comments.value = r;
      stateComment.value = ContentState();
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

  deleteComment(Comment comment){
    Get.find<PostController>().deleteComment(comment);
  }

}