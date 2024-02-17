import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/user/auth/controller/auth_controller.dart';
import 'package:maseef_app/widgets/custom_text_form_field.dart';

import '../../../core/utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/logo_widget.dart';

class UserRegisterPage extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        leading: IconButton(onPressed: () {
          Get.back();
        },
            icon: Icon(Icons.arrow_back_ios)),
      ) ,
      backgroundColor: ColorConstant.backgroundColor,
      body: Center(
        child: Obx(() {
          return controller.getState.getScreenWidget(
            RegisterScreenUI(registerController: controller),
                () {
              controller.login();
            },
          );
        }),
      ),
    );
  }
}

class RegisterScreenUI extends StatelessWidget {
  final AuthController registerController;

  const RegisterScreenUI({Key? key, required this.registerController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          LogoWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.alreadyRegistered,style: TextStyle(fontSize: 16.0),),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.userLoginScreen) ;
                },
                  child: Text(AppStrings.loginHere,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.black))),
            ],
          ),
          SizedBox(height: 30),
          TextFieldWidget(
            labelText: AppStrings.username,
            controller: registerController.usernameController,
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            labelText: AppStrings.emailLabel,
            controller: registerController.emailController,
          ),
          SizedBox(height: 20),

          TextFieldWidget(
            labelText: AppStrings.password,
            obscureText: registerController.obscurePassword.value,
            controller: registerController.passwordController,
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            labelText: AppStrings.cPassword,
            obscureText: registerController.obscurePassword.value,
            controller: registerController.cPasswordController,
          ),
          SizedBox(height: 20),
          ButtonWidget(onPressed:registerController.register, text:AppStrings.signUp,),

        ],
      ),
    );
  }
}

