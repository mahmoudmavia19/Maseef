import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/widgets/custom_text_form_field.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'controller/edit_post_controller.dart';

class EditPostScreen extends StatelessWidget {
  final EditPostController addPostController = Get.put(EditPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.editPost),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
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
                  child: Image.file(addPostController.selectedImage.value!,
                    alignment: Alignment.center,
                    height:200,
                    width: 100,fit: BoxFit.fitHeight,),
                )
                    : Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorConstant.primary,
                          width: 2.0
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                            ImageConstant.imageNotFound,
                          )
                      )
                  ),
                );
              }),
              SizedBox(height: 16.0),
              TextFieldWidget(labelText: AppStrings.address,
                  controller:  addPostController.postAddressController),
              SizedBox(height: 16.0),
              Obx(() {
                  return Container(
                    height: 200,
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      myLocationEnabled:true ,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          addPostController.currentLocation_.value.latitude ?? startMapLocation.latitude,
                          addPostController.currentLocation_.value.longitude ?? startMapLocation.longitude,
                        ),
                        zoom: 16,
                      ),
                      onMapCreated: (controller) {
                        addPostController.mapController = controller ;
                      },
                    onTap: (argument) {
                      print(argument);
                      addPostController.chooseLocation(argument);
                    },
                      markers: {
                        Marker(
                          markerId: MarkerId('currentLocation'),
                          position: LatLng(
                            addPostController.currentLocation_.value.latitude ??  startMapLocation.latitude,
                            addPostController.currentLocation_.value.longitude ?? startMapLocation.longitude,
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
                onPressed:()=>showConfirmationDialog((){
                  addPostController.editPost();
                }, 'are you sure', 'Alert'),
                child: Text(AppStrings.editPost),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
