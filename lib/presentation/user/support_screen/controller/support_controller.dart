import '../../../../core/app_export.dart';
import '../model/complaint_model.dart';

class ComplaintController extends GetxController {
  RxList<Complaint> complaints = <Complaint>[].obs;

  void addComplaint(String customerName, String description) {
    String complaintId = DateTime.now().millisecondsSinceEpoch.toString();
    Complaint newComplaint = Complaint(
      id: complaintId,
      customerName: customerName,
      description: description,
    );
    complaints.add(newComplaint);
  }
}