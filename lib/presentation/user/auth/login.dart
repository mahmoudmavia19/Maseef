import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/user/auth/controller/auth_controller.dart';
import 'package:maseef_app/widgets/custom_text_form_field.dart';

import '../../../core/utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/logo_widget.dart';

class UserLoginPage extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Center(
        child: Obx(() {
          return controller.getState.getScreenWidget(
            LoginScreenUI(loginController: controller),
                () {
              controller.login();
            },
          );
        }),
      ),
    );
  }
}

class LoginScreenUI extends StatelessWidget {
  final AuthController loginController;

  const LoginScreenUI({Key? key, required this.loginController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LogoWidget(),
          TextFieldWidget(
            labelText: AppStrings.usernameOrEmail,
            controller: loginController.emailController,
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            labelText: AppStrings.password,
            obscureText: loginController.obscurePassword.value,
            controller: loginController.passwordController,
          ),
          SizedBox(height: 20),
          ButtonWidget(onPressed: loginController.login, text:AppStrings.login,),
          SizedBox(height: 20),
            ForgotPasswordButtonWidget(),
        ],
      ),
    );
  }
}

class ForgotPasswordButtonWidget extends StatelessWidget {
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
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.userForgetPasswordScreen);
              },
              child: Text(
                AppStrings.forgotPassword2,
                style: TextStyle(color: ColorConstant.forgotPasswordTextColor, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
