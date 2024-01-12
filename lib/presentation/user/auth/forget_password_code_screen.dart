import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/user/auth/controller/auth_controller.dart';
import 'package:maseef_app/widgets/custom_text_form_field.dart';

import '../../../core/utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/logo_widget.dart';

class UserForgetPasswordCodePage extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        elevation: 0.0,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: ColorConstant.backgroundColor,
      body: Center(
        child: Obx(() {
          return controller.getState.getScreenWidget(
            ForgetPasswordScreenUI(loginController: controller),
                () {
              //controller.login();
            },
          );
        }),
      ),
    );
  }
}

class ForgetPasswordScreenUI extends StatelessWidget {
  final AuthController loginController;

  const ForgetPasswordScreenUI({Key? key, required this.loginController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LogoWidget(),
          TextFieldWidget(
            labelText: AppStrings.code,
            controller: loginController.codeController,
          ),

          SizedBox(height: 20),
          ButtonWidget(onPressed: (){
            Get.toNamed(AppRoutes.userNewPasswordCodeScreen);
          }, text:AppStrings.next,),
        ],
      ),
    );
  }
}

