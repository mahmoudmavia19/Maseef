import 'package:flutter/cupertino.dart';
import 'package:maseef_app/presentation/user/locations_screen/locations_screen.dart';
import 'package:maseef_app/presentation/user/love_posts_screen/love_posts_screen.dart';
import 'package:maseef_app/presentation/user/notification_screen/notification_screen.dart';

import '../../../../core/app_export.dart';
import '../../home_screen/home_screen.dart';

class MainController extends GetxController {

  RxInt currentIndex = 0.obs;

  PageController pageController = PageController();


  void changeIndex(int index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  List<Widget> pages = [
    HomeScreen(),
    LovePostsScreen(),
    NotificationScreen(),
    LocationsScreen()
   ];


}