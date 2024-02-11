// driver_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/driver.dart';

class DriverController extends GetxController {
  var drivers = <Driver>[].obs;
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  FlowState get getState => state.value;
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
  final TextEditingController driverNameController   = TextEditingController();
  final TextEditingController driverAgeController    = TextEditingController();
  final TextEditingController driverGenderController = TextEditingController();
  final TextEditingController driverPhoneController  = TextEditingController();
  final TextEditingController driverEmailController  = TextEditingController();
  final TextEditingController driverPasswordController  = TextEditingController();
  final TextEditingController driverConfPasswordController  = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _checkDrivers() {
    if(drivers.isEmpty) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Drivers Found');
    }else {
      state.value = ContentState();
    }
  }

  @override
  void onInit() {
    getDrivers();
    super.onInit();
  }

  void addDriver(Driver driver,) async{
    if(driverPasswordController.text != driverConfPasswordController.text) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'Passwords do not match');
    }else {
      state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
      (await remoteDataSource.addDriver(driver,driverPasswordController.text)).fold((failure) {
        state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
      }, (r) {
        _getDrivers();
        state.value = SuccessState(StateRendererType.popupSuccessState,'Driver added successfully');
      });
    }
  }
  void getDrivers() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getDrivers()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (r) {
      drivers.value = r;
      state.value = ContentState();
    });
  }

 Future<void> _getDrivers() async {
   (await remoteDataSource.getDrivers()).fold((failure) {
    }, (r) {
     drivers.value = r;
    });
  }
  void deleteDriver(int index) async{
    /// todo when driver try login if email&password is true but not found in database delete it from auth and show this user is deleted by admin
    state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    (await remoteDataSource.deleteDriver(drivers[index])).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (r) {
      drivers.removeAt(index);
      state.value = SuccessState(StateRendererType.popupSuccessState,'Driver deleted successfully');
    });

  }
}
