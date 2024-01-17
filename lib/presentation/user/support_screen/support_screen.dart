import 'package:flutter/material.dart';
import 'package:maseef_app/core/utils/app_strings.dart';

import '../../../core/app_export.dart';
import 'controller/support_controller.dart';

class SupportScreen extends StatelessWidget {
  final ComplaintController complaintController = Get.put(ComplaintController());
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.storeManagement),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: complaintController.complaints.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('Customer: Nora'),
                        subtitle: Text('Description: ${complaintController.complaints[index].description}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber[50]
                          ),
                          child: ListTile(
                            title: Text('Supporter: Mahmoud'),
                            subtitle: Text('Description: I will solve your problem'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
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
                  ),
                ),
                ElevatedButton(
                  child: Text(AppStrings.add),
                  onPressed: () {
                    complaintController.addComplaint(
                     'Nora',
                      _descriptionController.text,
                    );
                    _descriptionController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
