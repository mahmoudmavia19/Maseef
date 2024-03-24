import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';

class UserPostManageController extends GetxController {

   int index = Get.arguments[0];
   Rx<Post> post = Rx<Post>(Get.arguments[1]);
   UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
   Rx<FlowState> state =  Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    lovePost()async{
     post.value.love = !post.value.love ;
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
     (await remoteDataSource.likeOrDislikePost(post.value)).fold((failure) {
       state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
     },(r) {
      state.value = ContentState();
     }) ;

   }

 }