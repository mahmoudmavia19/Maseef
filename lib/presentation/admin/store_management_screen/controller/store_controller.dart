// store_controller.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/store.dart';

class StoreController extends GetxController {
  var stores = <Store>[].obs;
  var storesRequests = <Store>[].obs;
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  Rx<FlowState> stateRequests = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  FlowState get getState => state.value;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController discountCodeController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();
  final GlobalKey<FormState>  formKey = GlobalKey<FormState>();
  Rx<File?> imageFile = Rx<File?>(null);

  getImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      imageFile.value = File(value!.path);
    });
  }
  _checkStores() {
    if(stores.isEmpty) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Stores Found');
    }else {
      state.value = ContentState();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getStores();
  }

  void getStores() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getStores()).fold((l) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, l.message);
    }, (r) {
      stores.value = r.where((element) => element.accepted == true).toList();
      storesRequests.value = r.where((element) => element.accepted ==null).toList();
      state.value = ContentState();
    });
  }
  @override
  void onReady() {
    super.onReady();
  }
  void addStore() async{
 if(formKey.currentState!.validate()){
   state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
   Store newStore = Store(name: nameController.text,
       link: linkController.text,
       discountCode: discountCodeController.text,
       accepted: true,
       photoUrl: photoUrlController.text);
   (await remoteDataSource.addStore(newStore,imageFile.value!)).fold((l) {
     state.value = ErrorState(StateRendererType.fullScreenErrorState, l.message);
   }, (r) {
     clearControllers();
     getStores();
    });

 }
  }

  //clear all controllers
  void clearControllers() {
    nameController.clear();
    linkController.clear();
    discountCodeController.clear();
    photoUrlController.clear();
  }

  void editStore(int index, Store newStore) async{
    (await remoteDataSource.editStore(newStore)).fold((l) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, l.message);
    }, (r) {
      clearControllers();
      getStores();
    }) ;
  }

  void deleteStore(int index) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    stores.removeAt(index);
    _checkStores();
  }
}
