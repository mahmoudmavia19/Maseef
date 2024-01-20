 import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app_export.dart';



LatLng startMapLocation =  LatLng(24.774265, 46.738586);

 void showConfirmationDialog(Function action ,String message , String title) {
   Get.defaultDialog(
     title: title,
     middleText: message,
     confirm: ElevatedButton(
       onPressed: () {
          action();
         Get.back(); // Close the dialog
         Get.snackbar('Confirmed', 'Proceeding...');
       },
       child: Text('Confirm'),
     ),
     cancel: ElevatedButton(
       onPressed: () {
          Get.back(); // Close the dialog
         Get.snackbar('Canceled', 'Action canceled');
       },
       child: Text('Cancel'),
     ),
   );
 }


