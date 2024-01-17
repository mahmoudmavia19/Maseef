import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import 'model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<NotificationModel> notifications = [
      NotificationModel(
        leadingImage: 'https://img.freepik.com/free-photo/portrait-stylish-handsome-young-man_155003-12516.jpg?size=626&ext=jpg&ga=GA1.1.799096102.1685539358&semt=ais',
        title: 'Ahmed liked your comment',
        subtitle: 'on the post "This is a great post!"',
        trailingImage: 'https://img.freepik.com/free-photo/woman-standing-celsus-library-ephesus-ancient-city-izmir-turkey_335224-583.jpg?w=740&t=st=1705382865~exp=1705383465~hmac=4356df5592748bb9c81313ef1531951d6bf4e227573ac071257d9d56aea5d8fc',
        isSystemComment: false,
      ),

      NotificationModel(
        leadingImage: 'https://img.freepik.com/free-photo/medium-shot-beautiful-woman-wearing-hijab_23-2149226623.jpg?w=360&t=st=1705382521~exp=1705383121~hmac=8b933d3f44d2c26ea06fb7c328ee98c14ef841a6d473dad2e3dfcc68c1ccf95c',
        title: 'Sara replied to your comment',
        subtitle: 'on the post "This is a great post!"',
        trailingImage: 'https://img.freepik.com/premium-photo/young-happy-woman-tourist-walking-market-square-old-european-city-krakow-poland-travels-around-europe_194143-5192.jpg?w=740',
        isSystemComment: false,
      ),
      NotificationModel(
        leadingImage: 'https://img.freepik.com/free-photo/medium-shot-beautiful-woman-wearing-hijab_23-2149226623.jpg?w=360&t=st=1705382521~exp=1705383121~hmac=8b933d3f44d2c26ea06fb7c328ee98c14ef841a6d473dad2e3dfcc68c1ccf95c',
        title: 'You are close to Shubra Palace',
        subtitle: '100 meters away',
        isSystemComment: true,
      ),
      NotificationModel(
        leadingImage: 'https://img.freepik.com/free-photo/side-view-smiley-woman-wearing-sunglasses_23-2149642250.jpg?size=626&ext=jpg&ga=GA1.1.799096102.1685539358&semt=ais',
        title: 'Rakan liked your comment',
        subtitle: 'on the post "This is a great post!"',
        trailingImage: 'https://img.freepik.com/free-photo/fuji-mountain-kawaguchiko-lake-sunset-autumn-seasons-fuji-mountain-yamanachi-japan_335224-1.jpg?t=st=1705382865~exp=1705383465~hmac=d7fc91662d9f61cfd51b4db8da5a9030448d3c68176256f307e7c130e31e203b',
        isSystemComment: false,
      ),
      NotificationModel(
        leadingImage: 'https://img.freepik.com/free-photo/medium-shot-women-sitting-together_23-2149226611.jpg?w=360&t=st=1705382819~exp=1705383419~hmac=ffbb99df6772daa6af55543e7ba05bdc330619efa3156b7a3dc5ff8b2686133d',
        title: 'Sahab liked your comment',
        subtitle: 'on the post "This is a great post!"',
        trailingImage: 'https://img.freepik.com/free-photo/pink-tree-nami-island-korea_335224-522.jpg?t=st=1705382865~exp=1705383465~hmac=6a3d761005c417fe9e0d5dddc9f08004a8c4bf3aed4341744d2e09d262a27623',
        isSystemComment: false,
      ),
      // Add more notifications...
    ];

    return Scaffold(
      body: ScaffoldBackground(
        opacity: 0.9,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationItem(notification: notifications[index]);
          },
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
            !notification.isSystemComment
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
                  notification.leadingImage,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : SizedBox(
              width: 70,
              child: SvgPicture.asset(
                ImageConstant.location_icon,
                width: 40,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  notification.subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            Spacer(),
            !notification.isSystemComment
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
