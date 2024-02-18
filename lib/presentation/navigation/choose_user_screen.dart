import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
class ChooseUserScreen extends StatefulWidget {


  @override
  State<ChooseUserScreen> createState() => _ChooseUserScreenState();
}

class _ChooseUserScreenState extends State<ChooseUserScreen> {
  RxBool show = false.obs;

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 1000),
            (timer) {
              show.value = !show.value;
            }
        ,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
        title: Text('Choose User'),
      ) ,
      body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Obx(()=>Visibility(
                    visible: show.value,
                    child: CustomImageView(
                      imagePath: ImageConstant.logo,
                      width: 300.0,
                    ),
                  ),
                ),
                LottieBuilder.asset(
                  AppLotteAssets.load,
                  width: 300.0,
                 frameBuilder: (context, child, composition){
                   print('object');
                   return child;
                 },
                 ),
              ],
            ),
             SizedBox(height: 20.0,),
             SizedBox(
              width: 300.0,
              child: ElevatedButton(onPressed: (){
                Get.toNamed(AppRoutes.adminLoginScreen);
              },
                  child: Text(AppStrings.admin)
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox(
              width: 300.0,
              child: ElevatedButton(onPressed: (){
                Get.toNamed(AppRoutes.guestMainScreen);
              }, child: Text(AppStrings.user),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(ColorConstant.primaryMaterialColor[400]!),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox(
              width: 300.0,
              child: ElevatedButton(onPressed: (){
                Get.toNamed(AppRoutes.driverLoginScreen);
              }, child: Text(AppStrings.driver),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(ColorConstant.primaryMaterialColor[300]!),
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}
