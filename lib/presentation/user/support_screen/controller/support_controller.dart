import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../../../admin/complaint_screen/model/complaint.dart';

class ComplaintController extends GetxController {
  RxList<Complaint> complaints = <Complaint>[].obs;
  Rx<FlowState> flowState = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  UserRemoteDataSource userRemoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  void addComplaint(Complaint complaint) async{
    (await userRemoteDataSource.sendComplaint(complaint)).fold((l) {
      flowState.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      complaints.add(complaint);
      flowState.value = ContentState();
    });
  }

  void getComplaints() async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await userRemoteDataSource.getComplaints()).fold((l) {
      flowState.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      complaints.value = r;
      flowState.value = ContentState();
    });
  }
@override
  void onInit() {
    getComplaints() ;
    super.onInit();
  }


}