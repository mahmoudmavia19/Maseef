// bus_model.dart
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bus {
   String id;
  String busNumber;
  String departureTime;
  String arrivalTime;
  String address;
  LatLng stationLocation;
  LatLng? currentLocation;
  String driver;

  Bus({
    required this.id,
    required this.busNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.address,
    required this.driver,
    required this.stationLocation,
    this.currentLocation,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'],
      busNumber: json['busNumber'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      address: json['address'],
      driver: json['driver'],
      stationLocation: LatLng(
        json['stationLocation']['latitude'],
        json['stationLocation']['longitude'],
      ),
      currentLocation: json['currentLocation'] != null
          ? LatLng(
        json['currentLocation']['latitude'],
        json['currentLocation']['longitude'],
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'busNumber': busNumber,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'address': address,
      'driver': driver,
      'stationLocation': {
        'latitude': stationLocation.latitude,
        'longitude': stationLocation.longitude,
      },
    };
    if (currentLocation != null) {
      json['currentLocation'] = {
        'latitude': currentLocation!.latitude,
        'longitude': currentLocation!.longitude,
      };
    }
    return json;
  }
}
