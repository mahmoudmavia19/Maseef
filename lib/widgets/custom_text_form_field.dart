import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction ;

  const TextFieldWidget({
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction
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
        textInputAction:textInputAction,
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: ColorConstant.textFieldHint
          ),
          hintText: labelText,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}