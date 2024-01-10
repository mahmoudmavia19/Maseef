import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
 import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/widgets/custom_text_form_field.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import 'controller/add_post_controller.dart';

class AddPostScreen extends GetWidget<AddPostController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
        title: Text(AppStrings.addPost),
      ),
      body: ScaffoldBackground(
        child: Obx(() => controller.getState.getScreenWidget(_widget(context), () {

        }))
      ),
    );
  }

  _widget(context)=> SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.postTitle,style:Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: 16.0),
        TextFieldWidget(labelText: AppStrings.postTitle, controller:  controller.postTitleController),
        SizedBox(height: 16.0),
        Text(AppStrings.postContent,style:Theme.of(context).textTheme.titleLarge,),
        SizedBox(height: 16.0),
        TextFieldWidget(labelText: AppStrings.postContent,
            controller:  controller.postContentController),

        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: controller.pickImage,
          child: Text(AppStrings.pickImage),
        ),
        Obx(() {
          return (controller.selectedImage.value != null)
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(controller.selectedImage.value!,
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
            controller:  controller.postAddressController),
        SizedBox(height: 16.0),
        Obx(() {
          return Container(
            height: 200,
            child: GoogleMap(
              mapType: MapType.terrain,
              myLocationEnabled:true ,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                 controller.currentLocation_.value.latitude ?? startMapLocation.latitude,
                 controller.currentLocation_.value.longitude ?? startMapLocation.longitude,
                ),
                zoom: 16,
              ),
              onMapCreated: (_controller) {
                controller.mapController = _controller ;                    // Do other initialization as needed
              },
              onTap: (argument) {
                print(argument);
                controller.chooseLocation(argument);
              },
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: LatLng(
                 controller.currentLocation_.value.latitude ??  startMapLocation.latitude,
                 controller.currentLocation_.value.longitude ??  startMapLocation.longitude,
                  ),
                  infoWindow: InfoWindow(title: 'Current Location'),
                ),
              },
            ),
          );
        }),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: controller.addPost,
          child: Text(AppStrings.addPost),
        ),
      ],
    ),
  );
}
