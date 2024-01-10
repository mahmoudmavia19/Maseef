import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/category.dart';

class CategoryController extends GetxController {
   RxList<Category> categories = RxList<Category>();
   final TextEditingController addCategoryNameController = TextEditingController();
   final TextEditingController editCategoryNameController = TextEditingController();
   Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
   FlowState get getState => state.value;

   _checkCategories() {
     if(categories.isEmpty) {
       state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Categories Found');
     } else {
       state.value = ContentState();
     }
   }

   @override
  void onInit() {
     _checkCategories();
     super.onInit();
  }
  void addCategory(String name) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    categories.add(Category(id: DateTime.now().toString(), name: name));
    state.value = ContentState();
  }

  void editCategory(int index, String newName) {
    categories[index] =categories[index]..name = newName;
  }

  void deleteCategory(Category category) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    categories.remove(category);
    _checkCategories();
  }
}