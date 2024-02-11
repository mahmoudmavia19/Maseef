import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maseef_app/core/utils/app_strings.dart';

import 'core/app_export.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init() ,
    Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  )
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.primaryMaterialColor,
                foregroundColor: Colors.white,
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstant.primary)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstant.primary)),
        ),
         bottomNavigationBarTheme:BottomNavigationBarThemeData(
          backgroundColor: ColorConstant.backgroundColor,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0.0
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: ColorConstant.backgroundColor
        ),
        visualDensity: VisualDensity.standard,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black,fontSize: 24),
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
          color: ColorConstant.appBarColor
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorConstant.floatActionButColor,
          foregroundColor: Colors.white,
        ),
        primarySwatch: ColorConstant.primaryMaterialColor ,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ColorConstant.primaryMaterialColor ,
              backgroundColor: ColorConstant.primaryMaterialColor[50] ,
              brightness: Brightness.light
        )
      ),
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      //for setting localization strings
      fallbackLocale: const Locale('en', 'US'),
      title: AppStrings.appName,
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
    );
  }
}
