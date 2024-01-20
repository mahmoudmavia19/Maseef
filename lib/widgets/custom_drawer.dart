import 'package:flutter/material.dart';
 import 'package:maseef_app/core/app_export.dart';
import '../core/utils/app_strings.dart';

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
              Get.offAllNamed(AppRoutes.adminCategoryManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.postManagement,
            onTap: () {
              Get.offAllNamed(AppRoutes.adminPostManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.driversManagementTitle,
            onTap: () {
              Get.offAllNamed(AppRoutes.adminDriverManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.busManagement,
            onTap: () {
              Get.offAllNamed(AppRoutes.adminBusManagementScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.storeManagement,
            onTap: () {
              Get.offAllNamed(AppRoutes.adminStoreManagement);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.complaintsManagementTitle,
            onTap: () {
              Get.offAllNamed(AppRoutes.adminComplaintScreen);
            },
          ),
          _buildDrawerItem(
            title: AppStrings.logout,
            onTap: () {
              showConfirmationDialog((){
                Get.offAllNamed(AppRoutes.adminLoginScreen);
                },AppStrings.surelogout, 'Alert') ;
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