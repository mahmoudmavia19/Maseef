// complaints_management_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_image_view.dart';
import 'controller/complaint_controller.dart';
import 'model/complaint.dart';

class ComplaintsManagementScreen extends StatelessWidget {
  final ComplaintController complaintController = Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.complaintsManagementTitle),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
      ),
      body: Obx(
            () => ScaffoldBackground(
              child: ListView.builder(
                        itemCount: complaintController.complaints.length,
                        itemBuilder: (context, index) {
              Complaint complaint = complaintController.complaints[index];
              return Card(
                color: Colors.transparent,
                child: ListTile(
                  title:_subtitleItem('${AppStrings.customerNameLabel}:', complaint.customerName),
                  subtitle: _subtitleItem('${AppStrings.descriptionLabel}:', complaint.description),
                  trailing: ElevatedButton(
                    onPressed: () => complaintController.resolveComplaint(index),
                    child:Text(AppStrings.resolveButton),
                  ),
                ),
              );
                        },
                      ),
            ),
      ),

    );
  }


  _subtitleItem(String title, String subtitle) {
    return Wrap(
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width: 5.0,),
          Text(subtitle),
        ]
    );
  }
}
