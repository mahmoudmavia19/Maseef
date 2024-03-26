import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseef_app/presentation/user/home_screen/controller/home_controller.dart';

import '../../../../core/app_export.dart';

class LocationController extends GetxController {
  final RxSet<Marker> markers = <Marker>{}.obs;
  ImageConfiguration imageConfiguration = ImageConfiguration();
  HomeController homeController = Get.find<HomeController>();
  TextEditingController searchMap = TextEditingController();

  Future<void> addMarker(LatLng location,id) async {
    final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      ImageConstant.bus_location,
    );
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(title: 'Current Location'),
        icon: icon,
      ),
    );
  }

  @override
  void onInit() {
    addMarker(startMapLocation,0);
    homeController.posts.forEach((element) async{
      await addMarker(element.postLocation,element.postLocation);
    });
    super.onInit();
  }
}
