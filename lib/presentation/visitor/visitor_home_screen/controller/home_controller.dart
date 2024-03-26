import 'package:flutter/cupertino.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';

class GuestHomeController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  FlowState get getState => state.value;
  TextEditingController searchPostsController = TextEditingController();
  RxList<Post> posts = <Post>[].obs;

  onInit() {
    getAllPosts();
    super.onInit();
  }
  getAllPosts()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getAllPosts()).fold((failure) {
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



}