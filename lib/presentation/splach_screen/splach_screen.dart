import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate an async operation (e.g., loading resources, initializing)
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the main screen after 3 seconds
      Get.offAllNamed(AppRoutes.adminLoginScreen);
    });

    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Center(
        child: CustomImageView(
          imagePath: ImageConstant.logo,
        ),
      ),
    );
  }
}