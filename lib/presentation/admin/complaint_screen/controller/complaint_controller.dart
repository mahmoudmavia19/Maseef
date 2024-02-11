// complaint_controller.dart
import 'package:get/get.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/complaint.dart';

class ComplaintController extends GetxController {
  var complaints = <Complaint>[].obs;
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();

  @override
  void onInit() {
    super.onInit();
    getComplaint();
  }

  resolveComplaint(int index, String resolution) {
    state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    complaints[index].response = resolution;
    complaints[index].responseDate = DateTime.now();
    remoteDataSource.responseComplaint(complaints[index]).then((value) {
      state.value = SuccessState(StateRendererType.popupSuccessState, 'Success resolved complaint');
    }).catchError((error) {
      state.value = ErrorState(StateRendererType.popupErrorState, error);
    });
  }

  getComplaint()async{
    state.value = LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getComplaint()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    } , (complaints) {
      this.complaints.value = complaints;
      state.value = ContentState();
    });
  }

}
