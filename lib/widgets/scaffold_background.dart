import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';

class ScaffoldBackground extends StatelessWidget {
  Widget child;
  double opacity;

  ScaffoldBackground({required this.child , this.opacity = 0.6});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: child,
      decoration: BoxDecoration(
          color: ColorConstant.backgroundColorWithOpacity,
          image: DecorationImage(
              image: AssetImage(ImageConstant.background),
              fit: BoxFit.cover,
              opacity: opacity)),
    );
  }
}
