import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillCyan100 => BoxDecoration(
        color: ColorConstant.cyan100,
      );
  static BoxDecoration get fillDeeppurpleA200 => BoxDecoration(
        color: ColorConstant.deepPurpleA200,
      );
  static BoxDecoration get txtOutlineBlack90026 => BoxDecoration();
  static BoxDecoration get txtOutlinePinkA700 => BoxDecoration();
  static BoxDecoration get outlineDeeporangeA200 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            0,
          ),
          end: Alignment(
            0.5,
            1,
          ),
          colors: [
            ColorConstant.yellow500,
            ColorConstant.deepOrange400,
          ],
        ),
      );
  static BoxDecoration get outlineWhiteA700 => BoxDecoration(
        color: ColorConstant.deepPurpleA400,
        border: Border.all(
          color: ColorConstant.whiteA700,
          width: getHorizontalSize(
            2,
          ),
          strokeAlign: strokeAlignOutside,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90026,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              2,
            ),
          ),
        ],
      );
  static BoxDecoration get fillBlueA700 => BoxDecoration(
        color: ColorConstant.blueA700,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder17 = BorderRadius.circular(
    getHorizontalSize(
      17,
    ),
  );

  static BorderRadius roundedBorder14 = BorderRadius.circular(
    getHorizontalSize(
      14,
    ),
  );

  static BorderRadius roundedBorder4 = BorderRadius.circular(
    getHorizontalSize(
      4,
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
