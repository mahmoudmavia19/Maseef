// store_controller.dart
import 'package:get/get.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/store.dart';

class StoreController extends GetxController {
  var stores = <Store>[].obs;

  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  FlowState get getState => state.value;
  _checkStores() {
    if(stores.isEmpty) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Stores Found');
    }else {
      state.value = ContentState();
    }
  }

  @override
  void onInit() {
    _checkStores();
    super.onInit();
  }
  void addStore(Store store) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    stores.add(store);
    state.value = ContentState();
  }

  void editStore(int index, Store newStore) {
    stores[index] = newStore;
  }

  void deleteStore(int index) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    stores.removeAt(index);
    _checkStores();
  }
}
