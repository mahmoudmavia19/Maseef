import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';

 import '../../../widgets/custom_button.dart';
import '../../../widgets/logo_widget.dart';

class UserLoginOrRegister extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LogoWidget(),
              SizedBox(height: 20),
              ButtonWidget(onPressed:(){
                Get.toNamed(AppRoutes.userRegisterScreen);
              }, text: AppStrings.signUp,),
              SizedBox(height: 20),
              ButtonWidget(onPressed:(){
                 Get.toNamed(AppRoutes.userLoginScreen);
              }, text: AppStrings.login,opacity: 0.6),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Text('2024 Maseef, All Rights are Resaved.',style: TextStyle(color: Colors.grey),),
      ),
    );
  }
}
