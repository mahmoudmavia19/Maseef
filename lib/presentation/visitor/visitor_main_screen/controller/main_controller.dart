import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../visistor_locations_screen/locations_screen.dart';
import '../../visitor_discount_screen/discount_screen.dart';
import '../../visitor_home_screen/home_screen.dart';

class GuestMainController extends GetxController {

  RxInt currentIndex = 0.obs;

  PageController pageController = PageController();

  bool get  postsScreen => currentIndex.value == 0
  ;

  void changeIndex(int index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  List<Widget> pages = [
     GuestHomeScreen(),
     GuestLocationsScreen(),
     GuestDiscountScreen(),
   ];


}