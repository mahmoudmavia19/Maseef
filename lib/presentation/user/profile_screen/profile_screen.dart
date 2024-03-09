import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maseef_app/core/app_export.dart';
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
      body: ScaffoldBackground(
        opacity: 0.9,
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildUserImage(),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.editPicture,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextFormField(controller.nameController,
                  AppStrings.nameLabel, AppStrings.nameValidationMessage),
              const SizedBox(height: 16),
              _buildTextFormField(
                  controller.usernameController,
                  AppStrings.usernameLabel,
                  AppStrings.usernameValidationMessage),
              const SizedBox(height: 16),
              _buildTextFormField(controller.ageController, AppStrings.ageLabel,
                  AppStrings.ageValidationMessage),
              const SizedBox(height: 16),
              _buildTextFormField(controller.emailController,
                  AppStrings.emailLabel, AppStrings.emailValidationMessage , readOnly: true),
              const SizedBox(height: 16),
              _buildTextFormField(controller.genderController,
                  AppStrings.genderLabel, AppStrings.genderValidationMessage),
              const SizedBox(height: 16),
              _buildTextFormField(controller.phoneController,
                  AppStrings.phoneLabel, AppStrings.phoneValidationMessage),
              const SizedBox(height: 32),
              Obx(()=> Visibility(
                  visible: !controller.editMode.value,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.saveProfileInformation();
                    },
                    child: const Text(AppStrings.saveButtonLabel),
                    style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.primary),
                  ),
                ),
              ),
            ],
          ),
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

  Widget _buildUserImage() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: SvgPicture.asset(ImageConstant.user_placeholder),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText,
      String validationMessage,
      {bool? readOnly}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: readOnly ==true ? TextFormField(
        readOnly: readOnly!,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
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
          clipBehavior: Clip.antiAliasWithSaveLayer,
          controller: controller,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
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
