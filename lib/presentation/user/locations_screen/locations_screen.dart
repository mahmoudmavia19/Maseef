import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/user/locations_screen/controller/location_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'package:maseef_app/widgets/search_form.dart';

class LocationsScreen extends GetWidget<LocationController> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ScaffoldBackground(
        opacity: 0.9,
          child: Stack(
            children: [
              Obx(()=>GoogleMap(
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
                    ].toSet(),
                    initialCameraPosition: CameraPosition(
                      target:startMapLocation ,
                      zoom: 14.4746,
                    ),
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.terrain,
                  padding: EdgeInsets.only(top: 70),
                markers: controller.markers.map((element) => element).toSet(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SearchForm(),
              )
            ],
          )
      ),
    );
  }
}
