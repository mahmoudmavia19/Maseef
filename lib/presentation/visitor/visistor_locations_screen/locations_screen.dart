import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseef_app/presentation/visitor/visitor_home_screen/controller/home_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'package:maseef_app/widgets/search_map_form.dart';

import '../../../core/app_export.dart';


class GuestLocationsScreen extends StatelessWidget {
  GuestHomeController homeController = Get.find<GuestHomeController>();
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ScaffoldBackground(
        opacity: 0.9,
          child: Stack(
            children: [
              GoogleMap(
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
                  ].toSet(),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(24.774265, 46.738586),
                    zoom: 14.4746,
                  ),
                 myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.terrain,
                padding: EdgeInsets.only(top: 70),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SearchMapForm(controller:TextEditingController() ,items: homeController.posts,onSuggestionTap: (p0) {
                  Get.toNamed(AppRoutes.userLoginScreen);
                },),
              )
            ],
          )
      ),
    );
  }
}
