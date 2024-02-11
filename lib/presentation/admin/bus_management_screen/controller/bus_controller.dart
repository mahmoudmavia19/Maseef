// bus_controller.dart
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maseef_app/core/utils/image_constant.dart';
import 'package:maseef_app/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/bus.dart';

class BusController extends GetxController {
  var buses = <Bus>[].obs;
  final TextEditingController busNumberController = TextEditingController();
  final TextEditingController driverIdController = TextEditingController();
  final TextEditingController departureTimeController = TextEditingController();
  final TextEditingController arrivalTimeController = TextEditingController();
  final TextEditingController addressLocationController = TextEditingController();
  final TextEditingController driverController = TextEditingController();
 GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();
  late GoogleMapController mapController ;
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  FlowState get getState => state.value;
  Rx<BitmapDescriptor> iconLocation =Rx<BitmapDescriptor>(BitmapDescriptor.defaultMarker);
  _geButIconLocation() async{
    iconLocation.value =  await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(15,15)), // Adjust the size as needed
      ImageConstant.bus_location,
    );
  }
  _checkBuses() {
    if(buses.isEmpty) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, 'No Posts Found');
    }else {
      state.value = ContentState();
    }
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    _geButIconLocation() ;
    _getCurrentLocation();
    super.onInit();
    getBuses();
  }

  getBuses() async {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getBuses()).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
      },
      (buses) {
        this.buses.value = buses;
        state.value = ContentState();
      }
    );
  }



  chooseLocation(LatLng target ) {
    currentLocation_.value = LocationData.fromMap({
      'latitude': target.latitude,
      'longitude': target.longitude
    });
    getAddressFromCoordinates(LatLng(currentLocation_.value.latitude!,
        currentLocation_.value.longitude!));
  }
  Future<void> _getCurrentLocation() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    currentLocation_.value = currentLocation;
  }
  Future<void> getAddressFromCoordinates(LatLng latlng) async {
    try {
      List<geocoding.Placemark> placemarks =
      await geocoding.placemarkFromCoordinates(latlng.latitude,latlng.longitude);

      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks[0];
        print(
            "${placemark.street}, ${placemark.locality}, ${placemark.country}");
        addressLocationController.text = "${placemark.street}, ${placemark.locality}, ${placemark.country}";
      } else {
        print('No address found');
      }
    } catch (e) {
      print("Error: $e");
      print('Error getting address');
    }
  }

  void addBus(Bus bus)async {
    if(formKey.currentState!.validate()){
      state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      (await remoteDataSource.addBus(bus)).fold((l){
        state.value = ErrorState(StateRendererType.fullScreenErrorState, l.message);
      }, (r){
        buses.add(bus);
        state.value = ContentState();

        Get.back();
      });
    }
  }

  void editBus(int index, Bus updatedBus) async {
    if(formKey.currentState!.validate()){
      state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      (await remoteDataSource.editBus(updatedBus)).fold((l){
        state.value = ErrorState(StateRendererType.fullScreenErrorState, l.message);
      }, (r) {
        buses[index] = updatedBus;
        state.value = ContentState();
        Get.back();
      });
     }
  }

  void deleteBus(int index) async{
    state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    (await remoteDataSource.deleteBus(buses[index])).fold((l){
      state.value = ErrorState(StateRendererType.fullScreenErrorState, l.message);
    }, (r){
      buses.removeAt(index);
      state.value = SuccessState(StateRendererType.popupSuccessState, 'Bus deleted successfully');
    }) ;
  }
}
