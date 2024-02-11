import 'dart:io';

import 'package:get/get.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/post.dart';

class PostController extends GetxController {
  final posts = <Post>[].obs;
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
  FlowState get getState => state.value;

  @override
  void onInit() {
    super.onInit();
    getPosts();
   }

  getPosts()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getPosts()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(posts) {
       this.posts.value = posts;
       if(posts.isNotEmpty) {
         state.value = ContentState();
       } else
         {
           state.value = EmptyState('No Posts Found');
         }
       }
    );
  }

  _checkPosts() {
    if(posts.isEmpty) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Posts Found');
    }else {
      state.value = ContentState();
    }
  }



  void editPost(Post newPost,File? newFile) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.editPost(newPost,newFile)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(posts) {
       getPosts();
       state.value = SuccessState(StateRendererType.popupSuccessState, 'Post Edited Successfully');
     });

  }

  void deletePost(int index) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.deletePost(posts[index])).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(posts) {
       this.posts.removeAt(index);
      getPosts();
       Get.back();
    });
    print(posts[index].postId);
  }
}
