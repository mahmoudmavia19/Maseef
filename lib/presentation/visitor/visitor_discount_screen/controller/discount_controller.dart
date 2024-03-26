
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';

class DiscountController extends GetxController {
   Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    RxList<Store> stores = <Store>[].obs;
    RxList<Store> storesSearch = <Store>[].obs;
   UserRemoteDataSource  remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
   TextEditingController searchStoreController = TextEditingController();
   var  formKey = GlobalKey<FormState>();

   var imagePicker = ImagePicker();
   Rx<File?> image = Rx<File?>(null);

   pickImage()async{
      var res =  await imagePicker.pickImage(source: ImageSource.gallery);
     image.value = File(res!.path);
   }


    getAllStores()async{
      state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      (await remoteDataSource.getAllStores()).fold((failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      },(List<Store> stores) {
        this.stores.value = stores;
        if(stores.isNotEmpty) {
          state.value = ContentState();
        } else
          {
            state.value = EmptyState('No Stores Found');
          }
      }) ;
    }

    addStore(Store store)async{
     if(image.value == null){
       state.value = ErrorState(StateRendererType.popupErrorState, 'Please Select Image');
     } else {
      state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      (await remoteDataSource.addStore(store,image.value!)).fold((failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      },(r) {
        state.value = SuccessState(StateRendererType.popupSuccessState, 'Success Adding Store , Please Wait we will review it');
      }) ;
     }
    }

    search(){
        storesSearch.value = stores.where((element) => element.name.toLowerCase().contains(searchStoreController.text.toLowerCase())).toList();
        if(searchStoreController.text=='')
          storesSearch.value = [] ;
    }

    @override
  void onInit() {
    getAllStores();

    super.onInit();
  }
}