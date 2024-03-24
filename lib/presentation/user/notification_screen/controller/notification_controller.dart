import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/user/notification_screen/model/notification_model.dart';

class NotificationController extends GetxController {
  Rx<FlowState> flowState = Rx(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  UserRemoteDataSource userRemoteDataSource = Get.find<UserRemoteDataSourceImpl>() ;
  List<NotificationModel> notifications = [] ;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  getNotifications() async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await userRemoteDataSource.getNotifications()).fold((l) {
      flowState.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      notifications = r ;
      if(notifications.isNotEmpty)
      flowState.value = ContentState();
      else
      flowState.value = EmptyState('No Notifications');
    });
  }

}