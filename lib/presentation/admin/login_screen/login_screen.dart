import 'package:flutter/material.dart';
 import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/widgets/custom_text_form_field.dart';

import '../../../core/utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/logo_widget.dart';
 import 'controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
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
              TextFieldWidget(
                labelText: AppStrings.usernameOrEmail,
                controller: loginController.usernameController,
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                labelText: AppStrings.password,
                obscureText: loginController.obscurePassword.value,
                controller: loginController.passwordController,
              ),
              SizedBox(height: 20),
              ButtonWidget(onPressed: loginController.login),
              SizedBox(height: 20),
              _ForgotPasswordButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}


class _ForgotPasswordButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.forgotPassword,
              style: TextStyle(color: ColorConstant.forgotPasswordTextColor, fontSize: 14),
            ),
            SizedBox(width: 2.0,),
            Text(
              AppStrings.forgotPassword2,
              style: TextStyle(color: ColorConstant.forgotPasswordTextColor, fontSize: 14,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}