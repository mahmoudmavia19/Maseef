import 'package:flutter/material.dart';

import '../core/utils/image_constant.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        ImageConstant.logo,
        height: 250,
        width: 250,
      ),
    );
  }
}
