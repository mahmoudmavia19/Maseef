import 'dart:ffi';

import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

import '../../../admin/post_management_screen/model/comment.dart';

class HomeController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  List<Post> posts = [];
  UserRemoteDataSource  remoteDataSource = Get.find<UserRemoteDataSourceImpl>();

   getAllPosts()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getAllPosts()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(List<Post> posts) {
      this.posts = posts;
      if(posts.isNotEmpty) {
        state.value = ContentState();
      } else
        {
          state.value = EmptyState('No Posts Found');
        }
    }) ;
  }

  lovePost(int index) async{
    posts[index].love = !posts[index].love ;
    (await remoteDataSource.likeOrDislikePost(posts[index])).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(r) {
      getAllPosts();
    }) ;
  }

  addComment(Comment comment) async{
    (await remoteDataSource.addComment(comment)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (r) {
      getAllComments(comment.postId!);
    });
  }

 Future<List<Comment>> getAllComments(String post)async{
   List<Comment> comments = [];
    (await remoteDataSource.getAllComments(post)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (r) {
      comments = r;
       state.value = ContentState();
    });
    return comments;
  }
  @override
  void onInit() {
    getAllPosts(); 
    super.onInit();
  }

}