import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/category.dart';

class CategoryController extends GetxController {
   RxList<Category> categories = RxList<Category>();
   final TextEditingController addCategoryNameController = TextEditingController();
   final TextEditingController editCategoryNameController = TextEditingController();
   Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
   FlowState get getState => state.value;

   AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
   _checkCategories() {
     if(categories.isEmpty) {
       state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Categories Found');
     } else {
       state.value = ContentState();
     }
   }

   @override
  void onInit() {
     getCategories();

     super.onInit();
  }
  void getCategories()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getCategories()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },
        (categories) {
          this.categories.value = categories;
          _checkCategories();
        });
  }
  void addCategory(String name) async{
    var category =  Category(id: DateTime.now().toString(), name: name,createTime:DateTime.now());
    (await remoteDataSource.addCategory(category)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(categories) {
      this.categories.add(category);
      getCategories();
      SuccessState(StateRendererType.popupSuccessState, 'Category Added Successfully');
    });
  }

  void editCategory(int index, String newName) async{
    categories[index] =categories[index]..name = newName;
    (await remoteDataSource.editCategory(categories[index])).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(categories) {
      SuccessState(StateRendererType.popupSuccessState, 'Category Edited Successfully');
    });

  }

  void deleteCategory(Category category) async{
    (await remoteDataSource.deleteCategory(category)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (categories) {
      this.categories.remove(category);
      state.value = SuccessState(StateRendererType.popupSuccessState, 'Category Deleted Successfully');
    });
  }
}