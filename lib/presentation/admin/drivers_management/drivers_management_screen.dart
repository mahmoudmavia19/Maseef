// drivers_management_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_image_view.dart';
import 'controller/driver_controller.dart';
import 'model/driver.dart';


class DriversManagementScreen extends StatelessWidget {
  final DriverController driverController = Get.put(DriverController());
  final TextEditingController driverNameController   = TextEditingController();
  final TextEditingController driverAgeController    = TextEditingController();
  final TextEditingController driverGenderController = TextEditingController();
  final TextEditingController driverPhoneController  = TextEditingController();
  final TextEditingController driverEmailController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.driversManagementTitle),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
      ),
      body: Obx(
            () => ScaffoldBackground(
              child: driverController.state.value.getScreenWidget(_widget(), () {}),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDriverDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _widget()=>ListView.builder(
    itemCount: driverController.drivers.length,
    itemBuilder: (context, index) {
      Driver driver = driverController.drivers[index];
      return Card(
        color: Colors.transparent,
        child: ListTile(
          title: _subtitleItem(driver.name.toString(),''),
          subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _subtitleItem(AppStrings.ageLabel, driver.age.toString()) ,
              _subtitleItem(AppStrings.genderLabel, driver.gender) ,
              _subtitleItem(AppStrings.phoneLabel, driver.phone) ,
              _subtitleItem(AppStrings.emailLabel, driver.email),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete,color: Colors.red,),
            onPressed: () => driverController.deleteDriver(index),
          ),
        ),
      );
    },
  );

  Future<void> _showAddDriverDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppStrings.addDriver),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(controller: driverNameController,   label:AppStrings.driverNameLabel),
              _buildTextField(controller: driverAgeController,    label: AppStrings.ageLabel, keyboardType: TextInputType.number),
              _buildTextField(controller: driverGenderController, label:  AppStrings.genderLabel),
              _buildTextField(controller: driverPhoneController,  label:  AppStrings.phoneLabel, keyboardType: TextInputType.phone),
              _buildTextField(controller: driverEmailController,  label:  AppStrings.emailLabel, keyboardType: TextInputType.emailAddress),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () {
                if (_areFieldsValid()) {
                  Driver newDriver = Driver(
                    id: DateTime.now().toString(),
                    name: driverNameController.text,
                    age: int.parse(driverAgeController.text),
                    gender: driverGenderController.text,
                    phone: driverPhoneController.text,
                    email: driverEmailController.text,
                  );
                  driverController.addDriver(newDriver);
                  clearTextControllers([
                    driverNameController,
                    driverAgeController,
                    driverGenderController,
                    driverPhoneController,
                    driverEmailController,
                  ]);
                  Navigator.of(context).pop();
                }
              },
              child: Text(AppStrings.add),
            ),
          ],
        );
      },
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
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
    );
  }

  bool _areFieldsValid() {
    return driverNameController.text.isNotEmpty &&
        driverAgeController.text.isNotEmpty &&
        driverGenderController.text.isNotEmpty &&
        driverPhoneController.text.isNotEmpty &&
        driverEmailController.text.isNotEmpty;
  }
  void clearTextControllers(List<TextEditingController> controllers) {
  for (var controller in controllers) {
  controller.clear();
  }
  }
}
