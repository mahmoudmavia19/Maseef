import 'package:flutter/material.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

class LocationsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ScaffoldBackground(
        opacity: 0.9,
          child: Center(child: Text('Locations Screen'))),
    );
  }
}
