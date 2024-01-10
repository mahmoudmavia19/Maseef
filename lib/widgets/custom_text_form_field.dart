import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const TextFieldWidget({
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,),

      decoration: BoxDecoration(
        color: ColorConstant.primaryMaterialColor.withOpacity(0.5),
        boxShadow: [
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: ColorConstant.textFieldHint
          ),
          hintText: labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}