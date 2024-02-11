// add_edit_bus_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/widgets/custom_drop_down.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'controller/bus_controller.dart';
import 'model/bus.dart';

class AddEditBusScreen extends StatelessWidget {
  final BusController busController = Get.find();


  final bool isEdit;
  final int editIndex = Get.arguments ?? -1;

  AddEditBusScreen({
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
     final Bus? editBus = isEdit ? busController.buses[editIndex] : null;
    busController.busNumberController.text = editBus?.busNumber ?? '';
    busController.departureTimeController.text = editBus?.departureTime ?? '';
    busController.arrivalTimeController.text = editBus?.arrivalTime ?? '';
    busController.addressLocationController.text = editBus?.address ?? '';
    busController.driverController.text = editBus?.driver ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? AppStrings.editBus : AppStrings.addBus),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
      ),
      body: ScaffoldBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: busController.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: busController.busNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: AppStrings.busNumber,
                   ),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: busController.departureTimeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(labelText: AppStrings.departureTime),
                  textInputAction: TextInputAction.next,
                  readOnly: true,
                  onTap: () {
                    showDateTimePicker(context).then((value) {
                      busController.departureTimeController.text = value!.format(y_m_d_H_m_a);
                    });
                  },
                ),
                TextFormField(
                  controller: busController.arrivalTimeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: AppStrings.arrivalTime),
                  textInputAction: TextInputAction.next,
                  readOnly: true,
                  onTap: () {
                    showDateTimePicker(context).then((value) {
                      busController.arrivalTimeController.text = value!.format(y_m_d_H_m_a);
                    });
                  },
                ),
                TextFormField(
                  controller:busController.addressLocationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(labelText: AppStrings.stationLocation),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Driver',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    CustomDropDown(
                        variant: DropDownVariant.None,
                        hintText: busController.driverController.text.isEmpty
                            ? AppStrings.driver
                            : busController.driverController.text,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a driver';
                          }
                          return null;
                        },
                        onChanged: (p0) {
                          busController.driverController.text = p0.title;
                        },
                        items: [
                          SelectionPopupModel(title: 'Ahmed'),
                          SelectionPopupModel(title: 'Ali'),
                          SelectionPopupModel(title: 'Khalid'),
                        ]),
                    Divider(
                      color: Colors.black54,
                    ),
                  ],
                ),
                Obx(() {
                  return Container(
                    height: 200,
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      myLocationEnabled:true ,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          busController.currentLocation_.value.latitude ??  startMapLocation.latitude,
                          busController.currentLocation_.value.longitude ?? startMapLocation.longitude,
                        ),
                        zoom: 16,
                      ),
                      onMapCreated: (controller) {
                        busController.mapController = controller ;                    // Do other initialization as needed
                      },
                      onTap: (argument) {
                        print(argument);
                        busController.chooseLocation(argument);
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId('currentLocation',),
                          position: LatLng(
                            busController.currentLocation_.value.latitude ?? startMapLocation.latitude,
                            busController.currentLocation_.value.longitude ?? startMapLocation.longitude,
                          ),
                          infoWindow: InfoWindow(title: 'Current Location'),
                        ),
                      },
                    ),
                  );
                }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (isEdit) {
                      Bus updatedBus = Bus(
                        id: editBus!.id,
                        busNumber:busController. busNumberController.text,
                        departureTime: busController.departureTimeController.text,
                        arrivalTime:busController. arrivalTimeController.text,
                        address: busController.addressLocationController.text,
                        driver: busController.driverController.text,
                        stationLocation: LatLng(
                          busController.currentLocation_.value.latitude ?? 28.1253921,
                          busController.currentLocation_.value.longitude ?? 30.7480829,
                        )
                      );
                      busController.editBus(editIndex, updatedBus);
                    } else {
                      Bus newBus = Bus(
                        id: DateTime.now().toString(),
                        busNumber: busController.busNumberController.text,
                        departureTime:busController. departureTimeController.text,
                        arrivalTime:busController. arrivalTimeController.text,
                        address: busController.addressLocationController.text,
                        driver:busController. driverController.text,
                          stationLocation: LatLng(
                            busController.currentLocation_.value.latitude ?? 28.1253921,
                            busController.currentLocation_.value.longitude ?? 30.7480829,
                          )
                      );
                      busController.addBus(newBus);
                    }
                  },
                  child:
                      Text(isEdit ? AppStrings.saveChanges : AppStrings.addBus),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    return await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime.now().add(Duration(days: 365)), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
