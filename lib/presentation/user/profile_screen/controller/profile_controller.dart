// userProfile_controller.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';

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
  late UserModel user;
  var imagePicker = ImagePicker();
  Rx<XFile?> image = Rx<XFile?>(null);


   pickImage() async{
    image.value =  await imagePicker.pickImage(source: ImageSource.gallery);
    }

  Rx<FlowState> flowState = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  UserRemoteDataSource userRemoteDataSource = Get.find<UserRemoteDataSourceImpl>();

  getProfile () async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await userRemoteDataSource.getProfile()).fold((l) {
      flowState.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      user = r ;
      _loadUserData();
      flowState.value = ContentState();
    });
  }
  updateProfile()async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await userRemoteDataSource.updateProfile(user,image.value)).fold((l) {
      flowState.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      flowState.value = ContentState();
    });
  }
  toggleEditMode() {
    editMode.value = !editMode.value;
  }

  @override
  void onInit() {
     getProfile() ;
    super.onInit();

  }
  void _loadUserData() {
    nameController.text = user.name;
    usernameController.text = user.username;
    ageController.text = user.age.toString();
    emailController.text = user.email;
    genderController.text = user.gender;
    phoneController.text = user.phoneNumber;

  }

/*  void saveProfileInformation() {
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
  }*/
}
