import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/widgets/custom_text_form_field.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import 'controller/add_post_controller.dart';

class AddPostScreen extends StatelessWidget {
  final AddPostController addPostController = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addPost),
      ),
      body: ScaffoldBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppStrings.postTitle,style:Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 16.0),
              TextFieldWidget(labelText: AppStrings.postTitle, controller:  addPostController.postTitleController),
              SizedBox(height: 16.0),
              Text(AppStrings.postContent,style:Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 16.0),
              TextFieldWidget(labelText: AppStrings.postContent,
                  controller:  addPostController.postContentController),

              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: addPostController.pickImage,
                child: Text('Pick Image'),
              ),
              Obx(() {
                return (addPostController.selectedImage.value != null)
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(addPostController.selectedImage.value!,height: 100,width: 100,fit: BoxFit.fill,),
                )
                    : Container();
              }),
              SizedBox(height: 16.0),
              Obx(() {
                  return Container(
                    height: 200,
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      myLocationEnabled:true ,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          addPostController.currentLocation_.value.latitude ?? 28.1253921,
                          addPostController.currentLocation_.value.longitude ??30.7480829,
                        ),
                        zoom: 16,
                      ),
                      onMapCreated: (controller) {
                        addPostController.mapController = controller ;                    // Do other initialization as needed
                      },
                    onTap: (argument) {
                      print(argument);
                      addPostController.chooseLocation(argument);
                    },
                      markers: {
                        Marker(
                          markerId: MarkerId('currentLocation'),
                          position: LatLng(
                            addPostController.currentLocation_.value.latitude ?? 28.1253921,
                            addPostController.currentLocation_.value.longitude ?? 30.7480829,
                          ),
                          infoWindow: InfoWindow(title: 'Current Location'),
                        ),
                      },
                    ),
                  );
                }
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: addPostController.addPost,
                child: Text(AppStrings.addPost),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
