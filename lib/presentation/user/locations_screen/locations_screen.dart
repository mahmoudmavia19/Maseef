import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/user/locations_screen/controller/location_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'package:maseef_app/widgets/search_map_form.dart';

class LocationsScreen extends GetWidget<LocationController> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBackground(
        opacity: 0.9,
        child: Stack(
          children: [
            Obx(
                  () => GoogleMap(
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                  ),
                ].toSet(),
                initialCameraPosition: CameraPosition(
                  target: startMapLocation,
                  zoom: 14.4746,
                ),
                onMapCreated: (controller) async {
                  _controller.complete(controller);
                  googleMapController =await  _controller.future;
                },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.terrain,
                padding: EdgeInsets.only(top: 70),
                markers: controller.markers.toSet(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SearchMapForm(
                controller: controller.searchMap,
                items: controller.homeController.posts,
                onSuggestionTap: (p0) async {
                  print(p0);
                  await controller.addMarker(p0.item!.postLocation,p0.item!.postId);
                  (await _controller.future).animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: p0.item!.postLocation,
                        zoom: 14.4746,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
