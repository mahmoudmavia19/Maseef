import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/comment.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

import '../../../../core/app_export.dart';

class BlockUsersController extends GetxController {
   RxList<UserModel> users = <UserModel>[].obs;
   Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
   List<Comment> comments = Get.arguments;
   AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
   getUsers()async{
     state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
     users.value = [] ;
     for(var comment in comments){
    (await remoteDataSource.getUser(comment.userId!)).fold((l){

       }, (r){
          users.add(r);
       });
     }
     state.value = ContentState();
   }
   blockUser(int index)async{
      users[index].blocked =!users[index].blocked;
      (await remoteDataSource.updateUser(users[index])).fold((l) {

      }, (r){
        getUsers();
      });

   }
   @override
  void onInit() {
    getUsers();
    super.onInit();
  }
}