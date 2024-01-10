import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';

import '../presentation/admin/store_management_screen/model/store.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store store;

  Widget buildDiscountContainer() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: ColorConstant.discountColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          '${store.discountCode} discount',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.file(
               File( store.photoUrl),
                height: 150,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              buildDiscountContainer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: Text(
              store.name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
