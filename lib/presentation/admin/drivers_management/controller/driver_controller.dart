// driver_controller.dart
import 'package:get/get.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/driver.dart';

class DriverController extends GetxController {
  var drivers = <Driver>[].obs;
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  FlowState get getState => state.value;

  _checkDrivers() {
    if(drivers.isEmpty) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Drivers Found');
    }else {
      state.value = ContentState();
    }
  }

  @override
  void onInit() {
    _checkDrivers();
    super.onInit();
  }

  void addDriver(Driver driver) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    drivers.add(driver);
    state.value = ContentState();
  }

  void deleteDriver(int index) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    drivers.removeAt(index);
    _checkDrivers();
  }
}
