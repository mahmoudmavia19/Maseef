// userProfile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/app_export.dart';

import '../model/user_model.dart';

class UserProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool editMode = true.obs;
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();

  late final Rx<UserModel> user;

  toggleEditMode() {
    editMode.value = !editMode.value;
  }

  @override
  void onInit() {
    super.onInit();
    user = UserModel(
      id: '1', // Replace with the actual user ID
      name: 'John Doe', // Replace with the actual user name
      username: 'john_doe', // Replace with the actual username
      age: 25, // Replace with the actual age
      email: 'john.doe@example.com', // Replace with the actual email
      gender: 'Male', // Replace with the actual gender
      phoneNumber: '1234567890', // Replace with the actual phone number
      imagePath: ImageConstant.user_placeholder
    ).obs;
    _loadUserData();
  }

  void _loadUserData() {

    // Load user data from API or database and update the user object
    // For now, we use the initial values set in onInit
    nameController.text = user.value.name;
    usernameController.text = user.value.username;
    ageController.text = user.value.age.toString();
    emailController.text = user.value.email;
    genderController.text = user.value.gender;
    phoneController.text = user.value.phoneNumber;

  }

  void saveProfileInformation() {
    if (formKey.currentState!.validate()) {
      // Save the profile information
      user.update((val) {
        val!.name = nameController.text;
        val.username = usernameController.text;
        val.age = int.tryParse(ageController.text) ?? 0;
        val.email = emailController.text;
        val.gender = genderController.text;
        val.phoneNumber = phoneController.text;
      });
    }
  }
}
