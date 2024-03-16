 import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/driver_remote_data_source.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';

class DriverTrackingController extends GetxController {
  RxBool startTracking = false.obs;

  DriverRemoteDataSource driverRemoteDataSource = Get.find<DriverRemoteDataSourceImpl>();
  Rx<FlowState> state = Rx<FlowState>(ContentState());

  onReady() {
    super.onReady();
    shareLocation() ;
  }

  trackingToggle() {
    startTracking.value = !startTracking.value;
  }

  shareLocation() async {

   Geolocator.getPositionStream().listen((position) async{
    GeoPoint location = GeoPoint(position.latitude, position.longitude);
    print(location);
    if(startTracking.value) {
      (await driverRemoteDataSource.shareLocation(location)).fold((l) {
        state.value = ErrorState(StateRendererType.popupErrorState, l.message);
      }, (r) {
        state.value = ContentState();
      });
    }
   });
  }


}