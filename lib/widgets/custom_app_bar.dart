import 'package:flutter/material.dart';

import '../core/utils/image_constant.dart';

customAppBar(title) {
  return  AppBar(
    title: Text(title),
    actions: [
      Image.asset(
          ImageConstant.logo
      )
    ],
  );
}