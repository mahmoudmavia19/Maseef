// bus_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'model/bus.dart';

class BusDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bus bus = Get.arguments as Bus;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.busDetails),
      ),
      body: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppStrings.busNumber}: ${bus.busNumber}'),
              Text('${AppStrings.departureTime}: ${bus.departureTime}'),
              Text('${AppStrings.arrivalTime}: ${bus.arrivalTime}'),
              Text('${AppStrings.stationLocation}: ${bus.address}'),
              Text('${AppStrings.driver}: ${bus.driver}'),
            ],
          ),
        ),
      ),
    );
  }
}
