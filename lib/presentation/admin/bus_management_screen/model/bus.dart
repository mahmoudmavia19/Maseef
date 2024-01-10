// bus_model.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bus {
  final String id;
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
}
