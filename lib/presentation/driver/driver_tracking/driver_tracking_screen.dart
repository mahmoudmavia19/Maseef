import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/presentation/driver/driver_tracking/controller/driver_tracking_controller.dart';
import 'package:maseef_app/widgets/custom_app_bar.dart';

class DriverTracking extends GetWidget<DriverTrackingController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Driver Tracking'),
        actions: [
          IconButton(onPressed: () {
            showConfirmationDialog((){
              Get.offAllNamed(AppRoutes.chooseUser);
            },AppStrings.surelogout,'Alert');
          },icon: Icon(Icons.logout))
        ],
        leadingWidth: 100.0,
        toolbarHeight: 100.0,
        leading:  Image.asset(
            ImageConstant.logo
        ),
      ),
      body: Center(
        child:Obx(()=> GestureDetector(
          onTap: () {
            controller.trackingToggle();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${controller.startTracking.value ? 'Stop Tracking ...' : 'Start Tracking'}',style: TextStyle(fontSize: 20.0),),
              Lottie.asset(
                controller.startTracking.value? AppLotteAssets.tracking : AppLotteAssets.start,
                  width: 150.0,
                  fit: BoxFit.contain,
                ),
            ],
          ),
        ),
        ),
      ) ,
    );
  }
}
