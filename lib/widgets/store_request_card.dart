import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import '../presentation/admin/store_management_screen/model/store.dart';

class StoreRequestCard extends StatelessWidget {
  const StoreRequestCard({
    Key? key,
    required this.store,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  final Store store;
  final VoidCallback onAccept;
  final VoidCallback onReject;

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
              Image.network(
                store.photoUrl??'',
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  ImageConstant.imageNotFound,
                ),
                height: 150,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              buildDiscountContainer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  store.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: onAccept,
                      child: Text('Accept'),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: onReject,
                      child: Text('Reject'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
