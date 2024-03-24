import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import '../../../core/utils/app_strings.dart';
import 'controller/profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profileTitle),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Obx(()=>ScaffoldBackground(
          opacity: 0.9,
          child: controller.flowState.value.getScreenWidget(_body(), (){}),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.toggleEditMode();
        },
        child: Obx(() =>
            Icon(controller.editMode.value ? Icons.edit : Icons.edit_off)),
      ),
    );
  }
  
_body()=>Form(
  key: controller.formKey,
  child: ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _buildUserImage(),
      TextButton(
        onPressed: () {
          controller.pickImage();
        },
        child: Text(
          AppStrings.editPicture,
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 16),
      _buildTextFormField(controller.nameController,
          AppStrings.nameLabel, AppStrings.nameValidationMessage ,
      keyboardType: TextInputType.name,
      onChanged: (p0) {
        controller.user.name = p0;
      },),
      const SizedBox(height: 16),
      _buildTextFormField(
          controller.usernameController,
          AppStrings.usernameLabel,
          AppStrings.usernameValidationMessage,onChanged: (p0) {
            controller.user.username = p0;
          },keyboardType: TextInputType.name),
      const SizedBox(height: 16),
      _buildTextFormField(controller.ageController, AppStrings.ageLabel,
          AppStrings.ageValidationMessage,
          keyboardType: TextInputType.number,
          onChanged: (p0) {
            controller.user.age = int.parse(p0);
          }),
      const SizedBox(height: 16),
      _buildTextFormField(controller.emailController,
          AppStrings.emailLabel, AppStrings.emailValidationMessage , readOnly: true,),
      const SizedBox(height: 16),
      Container(
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey.withOpacity(0.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16,),
        child: DropdownButtonFormField<String>(
          items: [
         'Male',
         'Female',
        ].map((e) => DropdownMenuItem<String>(child: Text(e),value:e)).toList(),
          value: 'Male',
          decoration: InputDecoration(
            labelText: AppStrings.genderLabel,
            border: InputBorder.none,
            enabledBorder: InputBorder.none
          ),
          onChanged: (p0) {
          controller.user.gender = p0??'';
        },
        ),
      ),
       const SizedBox(height: 16),
      _buildTextFormField(controller.phoneController,
          AppStrings.phoneLabel, AppStrings.phoneValidationMessage,onChanged: (p0) {
            controller.user.phoneNumber = p0;
          },
          keyboardType: TextInputType.phone),
      const SizedBox(height: 32),
      Obx(()=> Visibility(
        visible: !controller.editMode.value,
        child: ElevatedButton(
          onPressed: () {
              controller.updateProfile();
          },
          child: const Text(AppStrings.saveButtonLabel),
          style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.primary),
        ),
      ),
      ),
    ],
  ),
);
  Widget _buildUserImage() {
    return Container(
      width: 100.0,
      height: 100.0,
      clipBehavior: Clip.antiAlias,
      child:Obx(()=>
           controller.image.value !=null ? Image.file(File(controller.image.value!.path)) :
               controller.user.imagePath == ''?
               SvgPicture.asset(ImageConstant.user_placeholder) :
          Image.network(controller.user.imagePath )),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText,
      String validationMessage,
      {bool? readOnly , void Function(String)? onChanged, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey.withOpacity(0.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16,),
      child: readOnly ==true ? TextFormField(
        readOnly: readOnly!,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: labelText,
          border:InputBorder.none,
          enabledBorder: InputBorder.none,
        ),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      )  :  Obx(
        () => TextFormField(
          readOnly:  this.controller.editMode.value,
          keyboardType: keyboardType,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          controller: controller,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMessage;
            }
            return null;
          },
        ),
      ),
    );
  }
}
