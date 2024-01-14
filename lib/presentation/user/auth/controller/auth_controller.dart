import 'package:flutter/material.dart';

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


  Rx<FlowState> state = Rx<FlowState>(ContentState());

  FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    Future.delayed(Duration(seconds: 5), () {
      Get.toNamed(AppRoutes.userMainScreen);
    });
  }
  void register() {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    Future.delayed(Duration(seconds: 5), () {
      Get.toNamed(AppRoutes.userMainScreen);
    });
  }
}