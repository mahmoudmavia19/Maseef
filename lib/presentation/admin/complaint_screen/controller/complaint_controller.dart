// complaint_controller.dart
import 'package:get/get.dart';

import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/complaint.dart';

class ComplaintController extends GetxController {
  var complaints = <Complaint>[].obs;
  Rx<FlowState> state = Rx<FlowState>(ContentState());

  @override
  void onInit() {
    complaints.add(Complaint(id: 'id', customerName: 'Kolola', description: 'I Have Problems'));
    complaints.add(Complaint(id: 'id', customerName: 'Alia', description: 'I Can\'nt Find My Bus'));
    complaints.add(Complaint(id: 'id', customerName: 'zozo', description: 'I Can\'nt Find Location'));
    super.onInit();
  }

  resolveComplaint(int index) {

  }
}
