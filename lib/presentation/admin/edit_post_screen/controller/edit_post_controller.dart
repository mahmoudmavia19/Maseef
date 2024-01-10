import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/controller/post_controller.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';

import '../../../../core/app_export.dart';

class EditPostController extends GetxController {
  final postTitleController = TextEditingController();
  final postContentController = TextEditingController();
  final postAddressController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
 final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController ;
  int index = Get.arguments;
  Post post =   Get.find<PostController>().posts[Get.arguments];
  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    _getCurrentLocation();

    postContentController.text = post.postContent;
    postTitleController.text = post.postTitle;
    postAddressController.text = post.addressLocation;
    selectedImage.value = File(post.postImage);


    super.onInit();
    currentLocation_.value =LocationData.fromMap({
      'latitude': post.postLocation.latitude,
      'longitude': post.postLocation.longitude
    });
  }

  Future<void> getAddressFromCoordinates(LatLng latlng) async {
    try {
      List<geocoding.Placemark> placemarks =
      await geocoding.placemarkFromCoordinates(latlng.latitude,latlng.longitude);

      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks[0];
        print(
            "${placemark.street}, ${placemark.locality}, ${placemark.country}");
        postAddressController.text = "${placemark.street}, ${placemark.locality}, ${placemark.country}";
      } else {
        print('No address found');
      }
    } catch (e) {
      print("Error: $e");
      print('Error getting address');
    }
  }

  chooseLocation(LatLng target ) {
    currentLocation_.value = LocationData.fromMap({
      'latitude': target.latitude,
      'longitude': target.longitude
    });
    getAddressFromCoordinates(LatLng(currentLocation_.value.latitude!, currentLocation_.value.longitude!));
  }
  Future<void> _getCurrentLocation() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    currentLocation_.value = currentLocation;
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> editPost() async {
    Get.find<PostController>().posts[index] = Post(
        postId: DateTime.now().toString(),
        adminId: '2232',
        postDate: DateTime.now(),
        postContent: postContentController.text,
        postLocation:LatLng(
            currentLocation_.value.latitude!,
            currentLocation_.value.longitude!),
        postImage: selectedImage.value!.path,
        addressLocation: postAddressController.text,
        postTitle: postTitleController.text);
  Get.back();
  }
}