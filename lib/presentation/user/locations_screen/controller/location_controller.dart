import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/user/home_screen/controller/home_controller.dart';
import 'package:geolocator/geolocator.dart' ;
import 'package:maseef_app/presentation/user/notification_screen/model/notification_model.dart';
import '../../../../core/app_export.dart';

class LocationController extends GetxController {
  final RxSet<Marker> markers = <Marker>{}.obs;
  ImageConfiguration imageConfiguration = ImageConfiguration();
  HomeController homeController = Get.find<HomeController>();
  TextEditingController searchMap = TextEditingController();
  final Completer<GoogleMapController> controllerMap = Completer();
  late GoogleMapController googleMapController ;
  UserRemoteDataSource userRemoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  // get my location
  Location location = Location();
  LocationData? _currentLocation;
  bool flag = false ;
  _getCurrentLocation() async {
    try {
      var currentLocation = await location.onLocationChanged.listen((event)async {
        _currentLocation = event;
        print(_currentLocation!.latitude);

        for(var post in homeController.postsLove){
          if(Geolocator.distanceBetween(event.latitude!, event.longitude!, post.postLocation.latitude, post.postLocation.longitude) <= 150 ){
            if(!flag) {
              Get.snackbar('Alert', 'You are near ${post.postTitle}');
              (await userRemoteDataSource.sendForYouNotification(
                  homeController.profileController.user.id, NotificationModel(
                  leadingImage: post.postImage,
                  trailingImage: post.postImage,
                  date: DateTime.now(),
                  postId: post.postId,
                  title: 'Alert',
                  subtitle: 'You are near ${post.postTitle}',
                  isSystemComment: true)));
              flag = true;
            }
          }
        }
      });


    } catch (e) {
      print('Error: $e');
    }
  }


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
  void onInit() async{
    addMarker(startMapLocation,0);
    homeController.posts.forEach((element) async{
      await addMarker(element.postLocation,element.postLocation);
    });
    await _getCurrentLocation();
    super.onInit();
  }
}
