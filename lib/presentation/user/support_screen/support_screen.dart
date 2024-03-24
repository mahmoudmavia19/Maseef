import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/admin/complaint_screen/model/complaint.dart';
import 'package:maseef_app/presentation/user/profile_screen/controller/profile_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import '../../../core/app_export.dart';
import 'controller/support_controller.dart';

class SupportScreen extends StatelessWidget {
  final ComplaintController complaintController = Get.put(ComplaintController());
  final TextEditingController _descriptionController = TextEditingController();
  UserProfileController userProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.supportScreen),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: ScaffoldBackground(
        opacity: 0.9,
        child: Column(
          children: [
            Expanded(
              child: Obx(
                    () => complaintController.flowState.value.getScreenWidget(_body(), (){
                      complaintController.getComplaints();
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Remove the customer name TextField
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Type your complaint...',
                      suffixIcon:   Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          child: Text(AppStrings.add),
                          onPressed: () {
                            complaintController.addComplaint(
                              Complaint(
                                createTime: DateTime.now(),
                                description: _descriptionController.text,
                                customerName: userProfileController.user.name,
                                customerId: userProfileController.user.id,
                              )
                            );
                            _descriptionController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
        
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _body()=>ListView.builder(
    itemCount: complaintController.complaints.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          ListTile(
            title: Text('Customer: ${complaintController.complaints[index].customerName}'),
            subtitle: Text('Description: ${complaintController.complaints[index].description}'),
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber[50]
                ),
                child: ListTile(
                  title: Text('Supporter'),
                  subtitle: Text('Description: ${complaintController.complaints[index].response}'),
                ),
              ),
            ),
            visible: complaintController.complaints[index].response != null,
          ),
        ],
      );
    },
  ); 
}
