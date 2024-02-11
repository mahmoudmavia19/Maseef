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
        // Get.snackbar('Confirmed', 'Proceeding...',);
       },
       child: Text('Confirm'),
     ),
     cancel: ElevatedButton(
       onPressed: () {
          Get.back(); // Close the dialog
         Get.snackbar('Canceled', 'Action canceled');
       },
       style: ButtonStyle(
         backgroundColor: MaterialStateProperty.all(Colors.grey),
       ),
       child: Text('Cancel'),
     ),
   );
 }

 void nullVoid (){}

// isNumeric must start with 05 and have 10 digits
 isNumeric(String value) {
   if (value.startsWith('05') && value.length == 10) {
     return true;
   }
   return false;
 }

 bool isPasswordSecure(String password) {
   // Check the length of the password
   if (password.length < 8) {
     return false;
   }

   // Check if password contains uppercase letters
   if (!password.contains(RegExp(r'[A-Z]'))) {
     return false;
   }

   // Check if password contains lowercase letters
   if (!password.contains(RegExp(r'[a-z]'))) {
     return false;
   }

   // Check if password contains numbers
   if (!password.contains(RegExp(r'[0-9]'))) {
     return false;
   }

   // Check if password contains special characters
   if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
     return false;
   }

   // If all criteria pass, the password is considered secure
   return true;
 }

 bool isEmailValid (String email) {
   return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
 }

