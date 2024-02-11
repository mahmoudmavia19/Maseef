// drivers_management_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/constants/constants.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_image_view.dart';
import 'controller/driver_controller.dart';
import 'model/driver.dart';


class DriversManagementScreen extends StatelessWidget {
  final DriverController driverController = Get.put(DriverController());

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
        onPressed: () => _showAddDriverDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  _widget()=>RefreshIndicator(
    onRefresh: () {
      driverController.getDrivers() ;
      return Future.value(true);
    },
    child: ListView.builder(
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
              onPressed: () => showConfirmationDialog((){
                driverController.deleteDriver(index);
              }, AppStrings.sureDelete, 'Alert'),
            ),
          ),
        );
      },
    ),
  );

  Future<void> _showAddDriverDialog() async {
    return Get.dialog(AlertDialog(
          title: Text(AppStrings.addDriver),
          content: SingleChildScrollView(
            child: Form(
              key: driverController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(controller: driverController.driverNameController,   label:AppStrings.driverNameLabel),
                  _buildTextField(controller: driverController.driverAgeController,    label: AppStrings.ageLabel, keyboardType: TextInputType.number),
                  _buildTextField(controller: driverController.driverGenderController, label:  AppStrings.genderLabel),
                  _buildTextField(controller: driverController.driverPhoneController,  label:  AppStrings.phoneLabel, keyboardType: TextInputType.phone),
                  _buildTextField(controller: driverController.driverEmailController,  label:  AppStrings.emailLabel, keyboardType: TextInputType.emailAddress),
                  _buildTextField(controller: driverController.driverPasswordController,  label:  AppStrings.password, keyboardType: TextInputType.visiblePassword),
                  _buildTextField(controller: driverController.driverConfPasswordController,  label:  AppStrings.confirmPassword, keyboardType: TextInputType.visiblePassword),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () {
                if (driverController.formKey.currentState!.validate()) {
                  Driver newDriver = Driver(
                     name:driverController.driverNameController.text,
                    age: int.parse(driverController.driverAgeController.text),
                    gender:driverController.driverGenderController.text,
                    phone:driverController.driverPhoneController.text,
                    email:driverController.driverEmailController.text,
                  );
                  driverController.addDriver(newDriver);
                  clearTextControllers([
                   driverController.driverNameController,
                   driverController.driverAgeController,
                   driverController.driverGenderController,
                   driverController.driverPhoneController,
                   driverController.driverEmailController,
                  ]);
                }
              },
              child: Text(AppStrings.add),
            ),
          ],
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
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label,
       border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstant.primary)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstant.primary)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if(keyboardType == TextInputType.visiblePassword){
          if(value.length < 8){
            return 'Password must be at least 8 characters';
          }else if(!isPasswordSecure(value)) {
            return 'Password is not secure';
          }
        }
        if(keyboardType == TextInputType.phone){
          if(!isNumeric(value)){
            return  'Please start with 05 and 10 digits';
          }
        }
        if(keyboardType == TextInputType.emailAddress){
          if(!isEmailValid(value)){
            return 'Please enter a valid email';
          }
        }
        return null;
      },
      keyboardType: keyboardType,
    );
  }

  bool _areFieldsValid() {
    return driverController.driverNameController.text.isNotEmpty &&
      driverController. driverAgeController.text.isNotEmpty &&
      driverController. driverGenderController.text.isNotEmpty &&
      driverController. driverPhoneController.text.isNotEmpty &&
      driverController. driverPasswordController.text.isNotEmpty &&
      driverController. driverConfPasswordController.text.isNotEmpty &&
      driverController. driverEmailController.text.isNotEmpty;
  }
  void clearTextControllers(List<TextEditingController> controllers) {
        for (var controller in controllers) {
            controller.clear();
        }
  }
}
