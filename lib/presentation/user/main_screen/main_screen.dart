
import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/presentation/user/main_screen/controller/main_controller.dart';

class MainScreen extends GetWidget<MainController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer() ,
      endDrawer: _endDrawer() ,
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
  _endDrawer(){
    return Drawer(
      backgroundColor: ColorConstant.backgroundColor,
      width: 200.0,
      child:ListView(
        children: [
          DrawerHeader(child:
          Column(
            children: [
              CustomImageView(
                svgPath: ImageConstant.user_placeholder,
                width: 80,
              ),
              SizedBox(height: 5.0,),
              Text("Ahmed Zaki",style: TextStyle(fontWeight: FontWeight.bold,),),
              Text("@ahmedZaki12",style: TextStyle(fontSize: 10.0,),),
            ],
          ),

          ),
          _tab(AppStrings.profile,(){}),
          _tab(AppStrings.language,(){}),
          _tab(AppStrings.privacyPolicy,(){}),
          _tab(AppStrings.termsAndConditions,(){}),
          _tab(AppStrings.support,(){}),
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
      actions: [
        Builder(
          builder: (innerContext) => InkWell(
            onTap: () {
              Scaffold.of(innerContext).openEndDrawer();
            },
            child: Image.asset(
              ImageConstant.settings,
              width: 50.0,
            ),
          ),
        ),
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
          activeIcon: CustomImageView(svgPath: ImageConstant.love_icon,width: 40,color: Colors.grey),
          icon:  CustomImageView(svgPath: ImageConstant.love_icon,width: 40),label: AppStrings.support),
      BottomNavigationBarItem(
          activeIcon: CustomImageView(svgPath: ImageConstant.notification_icon,width: 30,color: Colors.grey),
          icon: CustomImageView(svgPath: ImageConstant.notification_icon,width: 30),label: AppStrings.storeManagement),
      BottomNavigationBarItem(
          activeIcon: CustomImageView(svgPath: ImageConstant.location_icon,width: 30,color: Colors.grey),
          icon: CustomImageView(svgPath: ImageConstant.location_icon,width: 30),label: AppStrings.ageLabel),
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
