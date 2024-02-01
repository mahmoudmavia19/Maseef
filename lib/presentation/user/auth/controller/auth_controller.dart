import 'package:flutter/material.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  Rx<FlowState> state = Rx<FlowState>(ContentState());

  FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      (await remoteDataSource.login(email: emailController.text,
          password:passwordController.text)).fold((l) {
    state.value = ErrorState(StateRendererType.popupErrorState,l.message);
    }, (r) {
    state.value = ContentState();
    Get.toNamed(AppRoutes.userMainScreen,arguments: [r]);
    });
    }
  void register() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    if(passwordController.text == cPasswordController.text){
      if(isPasswordSecure(passwordController.text)){


      (await remoteDataSource.register(user:UserModel(
        name: userNameController.text,
        email: emailController.text,
        phoneNumber: '',
        age: 0 ,
        gender: '',
        imagePath: '',
        username:  userNameController.text, id: '',
      ) , password:passwordController.text)).fold((l) {
        state.value = ErrorState(StateRendererType.popupErrorState,l.message);
      }, (r) {
        state.value = ContentState();
        Get.toNamed(AppRoutes.userMainScreen,arguments: [r]);
      });
      } else {
        state.value = ErrorState(StateRendererType.popupErrorState,'Password is not secure');
      }
    } else {
      state.value = ErrorState(StateRendererType.popupErrorState,'Passwords do not match');
    }
  }

  void forgetPassword() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    if(isEmailValid(emailController.text)){
    (await remoteDataSource.forgetPassword(emailController.text)).fold((l) {
      state.value = ErrorState(StateRendererType.popupErrorState,l.message);
    }, (r) {
      state.value = SuccessState(StateRendererType.popupSuccessState,'Password reset link has been sent to your email');
    });
    } else {
      state.value = ErrorState(StateRendererType.popupErrorState,'Please enter a valid email');
    }
  }

}