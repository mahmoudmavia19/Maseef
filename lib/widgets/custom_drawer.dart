import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/app_export.dart';
import '../core/utils/app_strings.dart';
import '../routes/app_routes.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border(
               bottom: BorderSide(
                 color: ColorConstant.primary
               )
              ) ,
              color: ColorConstant.backgroundColor,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.logo,
                ),
                Text('Hallo Admin',style: TextStyle(color: ColorConstant.primary,fontWeight: FontWeight.bold),)
              ],
            )
          ),
          _buildDrawerItem(
            title: AppStrings.categoryManagement,
            onTap: () {
              Get.offAllNamed(AppRoutes.categoryManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.postManagement,
            onTap: () {
              Get.offAllNamed(AppRoutes.postManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.driversManagementTitle,
            onTap: () {
              Get.offAllNamed(AppRoutes.driverManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.busManagement,
            onTap: () {
              Get.offAllNamed(AppRoutes.busManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.storeManagement,
            onTap: () {
              Get.offAllNamed(AppRoutes.storeManagement);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.complaintsManagementTitle,
            onTap: () {
              Get.offAllNamed(AppRoutes.complaintScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.logout,
            onTap: () {
              Get.offAllNamed(AppRoutes.loginScreen);
            },
          ),
          // Add more items for other screens
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16.0),
          title: Text(title),
           trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        Divider(color: Colors.grey,),
      ],
    );
  }
}