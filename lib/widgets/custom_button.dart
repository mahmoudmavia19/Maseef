import 'package:flutter/material.dart';

import '../core/utils/app_strings.dart';
import '../core/utils/color_constant.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  double opacity ;
   ButtonWidget({required this.onPressed, required this.text,this.opacity = 1.0,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: ColorConstant.buttonColor.withOpacity(opacity),
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text,
          style: TextStyle(color: ColorConstant.loginButtonTextColor, fontSize: 16),
        ),
      ),
    );
  }
}
