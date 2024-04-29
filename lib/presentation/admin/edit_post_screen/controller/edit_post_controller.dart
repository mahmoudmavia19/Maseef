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
import '../../../../data/remote_data_source/admin_remote_data_source.dart';
import '../../category_management_screen/model/category.dart';

class EditPostController extends GetxController {
  final postTitleController = TextEditingController();
  final postContentController = TextEditingController();
  final postAddressController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
 final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController ;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int index = Get.arguments;
  Category?  category ;
  AdminRemoteDataSource remoteDataSource = Get.find<AdminRemoteDataSourceImpl>();

  Post post =   Get.find<PostController>().posts[Get.arguments];
  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }


  RxList<Category> categories = <Category>[].obs;
  getCategories ()async{
    (await remoteDataSource.getCategories()).fold((failure) {},(r) {
      categories.value =r;

    },);
  }

  @override
  void onInit() async{
    _getCurrentLocation();
   await  getCategories ();
    postContentController.text = post.postContent;
    postTitleController.text = post.postTitle;
    postAddressController.text = post.addressLocation;
    category = categories.firstWhere((element) => element.id == post.category);

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
  var newPost = Post(
        postId:post.postId,
        adminId:post.adminId,
        category: category?.id,
        postDate: DateTime.now(),
        love: post.love,
        postContent: postContentController.text,
        postLocation:currentLocation_.value.latitude!=null?LatLng(
            currentLocation_.value.latitude!,
            currentLocation_.value.longitude!):post.postLocation,
        postImage: post.postImage,
        addressLocation: postAddressController.text,
        postTitle: postTitleController.text);
  Get.find<PostController>().editPost(newPost,selectedImage.value);

  }
}