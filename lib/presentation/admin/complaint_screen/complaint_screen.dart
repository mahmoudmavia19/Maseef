// complaints_management_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
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
      drawer: MainDrawer(),
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
                    onPressed: () => _showResolveDialog(context, index),
                    child:Text(AppStrings.resolveButton),
                  ),
                ),
              );},),
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
  _showResolveDialog(BuildContext context, int index) {
    TextEditingController resolutionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resolve Complaint'),
          content: TextField(
            controller: resolutionController,
            decoration: InputDecoration(labelText: 'Enter resolution'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String resolution = resolutionController.text;
                complaintController.resolveComplaint(index, resolution);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Resolve'),
            ),
          ],
        );
      },
    );
  }

}
