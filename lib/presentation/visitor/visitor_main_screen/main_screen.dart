
import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';

import 'controller/main_controller.dart';

class GuestMainScreen extends GetWidget<GuestMainController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       /* drawer: controller.postsScreen? _drawer() : null,*/
         appBar: _appBar(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: _pageView(),
    );
  }

  _drawer(){
    return Drawer(
      backgroundColor: ColorConstant.backgroundColor,
      width: 200.0,
      child:ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorConstant.backgroundColor ,
            ),
              child:
           CustomImageView(
             imagePath: ImageConstant.logo,
           )
          ),
          _tab(AppStrings.All,(){}),
          _tab(AppStrings.parks,(){}),
          _tab(AppStrings.historical_places,(){}),
          _tab(AppStrings.Malls,(){}),
          _tab(AppStrings.Hotels,(){}),
          _tab(AppStrings.Cafes,(){}),
          _tab(AppStrings.Restaurants,(){}),
          _tab(AppStrings.Projects,(){}),
        ],
      ),
    );
  }

  _tab(text,action)=>ListTile(
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.black),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
      ],
    ),
    onTap: action,
  );
  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 70.0,
      centerTitle: true,
      title: Image.asset(
        ImageConstant.logo,
        height: 100.0,
      ),
      leading:IconButton(onPressed: () {
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios)),
      actions: [
        IconButton(
            onPressed: (){
              Get.toNamed(AppRoutes.userLoginOrRegisterScreen);
            },
            icon: Row(
              children: [
                Icon(Icons.login),
                Text(AppStrings.login,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold ),),
              ],
            ))
      ],
     );
  }

  _bottomNavigationBar()=> Obx(()=> BottomNavigationBar(items: [
      BottomNavigationBarItem(
        backgroundColor: ColorConstant.backgroundColor,
          activeIcon:CustomImageView(svgPath: ImageConstant.home_icon,width: 40,color: Colors.grey,) ,
          icon: CustomImageView(svgPath: ImageConstant.home_icon,width: 40),
          label: AppStrings.add),
    BottomNavigationBarItem(
        activeIcon: CustomImageView(svgPath: ImageConstant.location_icon,width: 40,color: Colors.grey),
        icon: CustomImageView(svgPath: ImageConstant.location_icon,width: 40),label: AppStrings.ageLabel),
    BottomNavigationBarItem(
        activeIcon: CustomImageView(svgPath: ImageConstant.discount_icon,width: 30,color: Colors.grey),
        icon: CustomImageView(svgPath: ImageConstant.discount_icon,width: 30),label: AppStrings.Cafes),

    ],showSelectedLabels: false,showUnselectedLabels:false ,
      selectedIconTheme: IconThemeData(
        size: 40,
      ),
      unselectedIconTheme:  IconThemeData(
        size: 40,
      ),
      backgroundColor: ColorConstant.backgroundColor,
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.black,
    onTap: (value) => controller.changeIndex(value),
    currentIndex: controller.currentIndex.value,
    ),
  );

  _pageView()=>PageView.builder(
    controller: controller.pageController,
    onPageChanged: (value) => controller.changeIndex(value),
    itemBuilder: (context, index) => controller.pages[index],
    itemCount: controller.pages.length,
  );

}
