import 'package:flutter/material.dart';
import 'package:maseef_app/data/remote_data_source/driver_remote_data_source.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';

class DriverLoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  DriverRemoteDataSource driverRemoteDataSource = Get.find<DriverRemoteDataSourceImpl>();
  FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await driverRemoteDataSource.login(email: usernameController.text,password:  passwordController.text)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (r) {
      state.value = ContentState();
      Get.offAllNamed(AppRoutes.driverTrackingScreen);
    });

  }
}