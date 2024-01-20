import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/app_export.dart';

class LocationController extends GetxController {
  final RxSet<Marker> markers = <Marker>{}.obs;
  ImageConfiguration imageConfiguration = ImageConfiguration();
  Future<void> addMarker(LatLng location) async {
    final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      ImageConstant.bus_location,
    );

    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: location,
        infoWindow: InfoWindow(title: 'Current Location'),
        icon: icon,
      ),
    );
  }

  @override
  void onInit() {
    addMarker(startMapLocation);
     super.onInit();
  }
}
