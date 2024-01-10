import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color black900B2 = fromHex('#b2000000');

  static Color deepOrangeA200 = fromHex('#ff6332');

  static Color blueGray50 = fromHex('#eaecf0');

  static Color lightBlue300 = fromHex('#5fcfff');

  static Color blueA700 = fromHex('#0061ff');

  static Color gray50 = fromHex('#f9fbff');

  static Color yellow500 = fromHex('#ffee37');

  static Color black900 = fromHex('#000000');

  static Color pinkA700 = fromHex('#b20d78');

  static Color blueGray800 = fromHex('#37334d');

  static Color blueGray700 = fromHex('#424c5d');

  static Color blue5001 = fromHex('#e0ebff');

  static Color deepPurpleA400 = fromHex('#7031fc');

  static Color blueGray900 = fromHex('#262b35');

  static Color deepPurpleA200 = fromHex('#9a4afe');

  static Color deepOrange400 = fromHex('#f78a3b');

  static Color black90026 = fromHex('#26000000');

  static Color blueGray200 = fromHex('#bac1ce');

  static Color blueGray100 = fromHex('#d6dae2');

  static Color blue700 = fromHex('#1976d2');

  static Color blueGray400 = fromHex('#74839d');

  static Color blueGray600 = fromHex('#5f6c86');

  static Color blueGray40090 = fromHex('#9074839d');

  static Color gray900 = fromHex('#2a2a2a');

  static Color blue600 = fromHex('#228aed');

  static Color blueGray30087 = fromHex('#87919eab');

  static Color blue50 = fromHex('#eef4ff');

  static Color gray100 = fromHex('#f2f2f2');

  static Color whiteA70000 = fromHex('#00ffffff');

  static Color cyan100 = fromHex('#c1fdff');

  static Color whiteA700 = fromHex('#ffffff');



  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }



  /// app colors

  static   Color backgroundColor = fromHex('#FFECD3');
  static   Color primary = fromHex('#3A4D39');
  static   Color secoundry = fromHex('#6A4018');
  static   Color backgroundColorWithOpacity =  fromHex('#FFECD3');
  static   Color appBarColor = fromHex('#FFECD3');
  static   Color textFieldBackground =fromHex('#3A4D39');
  static   Color textFieldHint =fromHex('#737373');
  static  Color buttonColor = fromHex('#3A4D39');
    static const Color loginButtonTextColor = Colors.white;
  static const Color forgotPasswordTextColor = Colors.black;
  static   Color floatActionButColor = fromHex('#6B745F');
  static   Color discountColor = fromHex('#BC1823');
  static   Color deleteColor = fromHex('#BC1823');
  static   Color editColor = fromHex('#00BF63');
  static   Color userColor = fromHex('#FF914D');
  static MaterialColor primaryMaterialColor = MaterialColor(0xFF3A4D39, {
    50: Color(0xFF3A4D39),
    100: Color(0xFF3A4D39),
    200: Color(0xFF3A4D39),
    300: Color(0xFF3A4D39),
    400: Color(0xFF3A4D39),
    500: Color(0xFF3A4D39),
    600: Color(0xFF3A4D39),
    700: Color(0xFF3A4D39),
    800: Color(0xFF3A4D39),
    900: Color(0xFF3A4D39),
  });

}
