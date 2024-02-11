// driver_model.dart

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../data/models/user/user.dart';

class Driver extends User {
  final LatLng? currentLocation;
  Driver({
      String? id,
    required String name,
    required int age,
    required String gender,
    required String phone,
    required String email,
    this.currentLocation,
  }) : super(
    id: id,
    name: name,
    age: age,
    gender: gender,
    phone: phone,
    email: email,
  );


  factory Driver.fromJson(Map<String, dynamic> json) {
    // Parse the latitude and longitude from the JSON and create a LatLng instance
    final double latitude = json['currentLocation']['latitude'] ?? 0.0;
    final double longitude = json['currentLocation']['longitude'] ?? 0.0;
    final LatLng location = LatLng(latitude, longitude);

    return Driver(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      currentLocation: location,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'phone': phone,
      'email': email,
      'currentLocation': {
        'latitude': currentLocation?.longitude,
        'longitude': currentLocation?.longitude,
      },
    };
  }
}
