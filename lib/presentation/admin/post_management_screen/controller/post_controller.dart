import 'package:get/get.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';

import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/post.dart';

class PostController extends GetxController {
  final posts = <Post>[].obs;
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));


  FlowState get getState => state.value;

  @override
  void onInit() {

    super.onInit();
  _checkPosts();
  }

  _checkPosts() {
    if(posts.isEmpty) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Posts Found');
    }else {
      state.value = ContentState();
    }
  }

  void addPost(Post post) {
     state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    posts.add(post);
    state.value = ContentState();
  }


  void editPost(Post oldPost, Post newPost) {
    final index = posts.indexWhere((element) => element.postId == oldPost.postId);
    if (index != -1) {
      posts[index] = newPost;
    }
  }

  void deletePost(int index) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    posts.removeAt(index);
    _checkPosts();
  }
}
