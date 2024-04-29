import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/user/notification_screen/controller/notification_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import 'model/notification_model.dart';

class NotificationScreen extends GetWidget<NotificationController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ScaffoldBackground(
        opacity: 0.9,
        child: Obx(()=>controller.flowState.value.getScreenWidget(RefreshIndicator(
          onRefresh: () async{
            await controller.getNotifications();
          },
          child: ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context,index) {
              return NotificationItem(notification:controller.notifications[index]);
            },
          ),
        ), (){}),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('object');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            !notification.isSystemComment!
                ? Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  notification.leadingImage!,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : SizedBox(
              width: 70,
              child: SvgPicture.asset(
                ImageConstant.location_icon,
                width: 45,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  notification.subtitle!,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                    DateFormat.yMMMd().format(notification.date!)+" "+DateFormat.jm().format(notification.date!),
                  style: TextStyle(color: Colors.grey[600],fontSize: 12.0),
                ),
              ],
            ),
            Spacer(),
            !notification.isSystemComment!
                ? Image.network(
              notification.trailingImage!,
              width: 60, // Adjust the width as needed
              height: 60, // Adj
              fit: BoxFit.cover,
            )
                : SizedBox(), // Use a different icon for user comments
          ],
        ),
      ),
    );
  }
}
