
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/user/main_screen/controller/main_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MainScreen extends GetWidget<MainController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*drawer: controller.postsScreen? _drawer() : null,*/
        endDrawer: _endDrawer() ,
        appBar: _appBar(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: _pageView(),
    );
  }

  _endDrawer(){
    return Drawer(
      backgroundColor: ColorConstant.backgroundColor,
      width: 200.0,
      child:Column(
        children: [
          Obx(()=> controller.flowState.value.getScreenWidget(
            _drawerHeader(),
            (){},
          ),
          ),
          _tab(AppStrings.profile,(){
            Get.toNamed(AppRoutes.userProfileScreen) ;
          }),
          _tab(AppStrings.privacyPolicy,(){
            Get.toNamed(AppRoutes.userPrivacyPolicyScreen) ;
          }),
          _tab(AppStrings.termsAndConditions,(){
            Get.toNamed(AppRoutes.userTermsAndConditionsScreen) ;
          }),
          _tab(AppStrings.support,(){
            Get.toNamed(AppRoutes.userComplaintScreen) ;
          }),
          _tab(AppStrings.logout,(){
            Get.offAllNamed(AppRoutes.chooseUser);
          }),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 145,
                  child: ToggleSwitch(
                     initialLabelIndex: 0,
                    totalSwitches: 2,
                    centerText: true,
                    animate: true,
                    activeBgColor:[ ColorConstant.primary],
                    labels: ['EN', 'AR'],
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
            ),
          ),
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

  _drawerHeader()=>DrawerHeader(child:
  InkWell(
    onTap: () {
      Get.toNamed(AppRoutes.userProfileScreen) ;
    },
    child: Column(
      children: [
       Container(
         clipBehavior: Clip.antiAlias,
         decoration: BoxDecoration(
           shape: BoxShape.circle
         ),
         child: Image.network(controller.userModel.imagePath,fit: BoxFit.cover,
         height: 90.0,
         errorBuilder: (context, error, stackTrace) {
          return  CustomImageView(
             imagePath: ImageConstant.user_placeholder,
           );
         }
         ),
       ),
        SizedBox(height: 5.0,),
        Text(controller.userModel.name,style: TextStyle(fontWeight: FontWeight.bold,),),
        Text(controller.userModel.email,style: TextStyle(fontSize: 10.0,),),
      ],
    ),
  ),

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
        activeIcon: CustomImageView(svgPath: ImageConstant.location_icon,width: 40,color: Colors.grey),
        icon: CustomImageView(svgPath: ImageConstant.location_icon,width: 40),label: AppStrings.ageLabel),
      BottomNavigationBarItem(
          activeIcon: CustomImageView(svgPath: ImageConstant.notification_icon,width: 30,color: Colors.grey),
          icon: CustomImageView(svgPath: ImageConstant.notification_icon,width: 30),label: AppStrings.storeManagement),
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
