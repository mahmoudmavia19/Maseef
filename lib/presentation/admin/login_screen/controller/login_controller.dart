 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();

  FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.login(
      email: usernameController.text,
      password: passwordController.text
    )).fold((l) {
      state.value = ErrorState(StateRendererType.popupErrorState,l.message);
    },((r) {
      state.value = ContentState();
    }));
  }
}
