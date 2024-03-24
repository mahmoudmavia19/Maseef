import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';

class LovePostController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(
      stateRendererType: StateRendererType.fullScreenLoadingState));
  List<Post> posts = [];
  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();

  getLovePosts()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getLovePosts()).fold((failure) {
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
  @override
  void onInit() {
    getLovePosts();
    super.onInit();
  }


}