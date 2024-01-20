// bus_management_screen.dart
import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
  import '../../../core/utils/app_strings.dart';
import 'controller/bus_controller.dart';
import 'model/bus.dart';

class BusManagementScreen extends GetWidget<BusController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.busManagement),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
      ),
      body: Obx(
            () => ScaffoldBackground(
              child:  controller.getState.getScreenWidget(_widget(), () {})
            )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.adminAddBusScreen),
        child: Icon(Icons.add),
      ),
    );
  }

  _widget()=>ListView.builder(
    itemCount: controller.buses.length,
    itemBuilder: (context, index) {
      Bus bus = controller.buses[index];
      return Card(
        color: Colors.transparent,
        child: ListTile(
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black),
          subtitleTextStyle:TextStyle(fontSize: 16.0,color: Colors.black),
          title:  _subtitleItem('${AppStrings.busNumber}:', bus.busNumber),
          subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _subtitleItem('${AppStrings.departureTime}:', bus.departureTime),
              _subtitleItem('${AppStrings.arrivalTime}:', bus.arrivalTime),
              _subtitleItem('${AppStrings.stationLocation}:', bus.address),
              _subtitleItem('${AppStrings.driver}:', bus.driver),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit,color:ColorConstant.primaryMaterialColor,), onPressed: () {
                Get.toNamed(AppRoutes.adminEditBusScreen, arguments: index);
              },
              ),
              IconButton(
                icon: Icon(Icons.delete,color:Colors.red,), onPressed: () {
             showConfirmationDialog((){
               controller.deleteBus(index);
             }, AppStrings.sureDelete, 'Alert');
              },
              ),
            ],
          ),
          // onTap: () => Get.toNamed(AppRoutes.busDetailsScreen, arguments: bus),
        ),
      );
    },
  );
  _subtitleItem(String title, String subtitle) {
    return Wrap(
      children: [
        Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(width: 5.0,),
        Text(subtitle),
      ]
    );
  }
}
