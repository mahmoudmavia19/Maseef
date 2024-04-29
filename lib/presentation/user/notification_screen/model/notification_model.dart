import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? uid ;
  String? userId ;
  String? postId;
  String? leadingImage;
  DateTime? date;
    String? title;
    String? subtitle;
    String? trailingImage;
    bool? isSystemComment;

  NotificationModel({
    required this.leadingImage,
    required this.title,
    required this.subtitle,
      this.trailingImage,
    required this.isSystemComment,
     this.userId,
    this.uid,
    this.date,
    this.postId,
  });

  NotificationModel.fromJson(Map<String, dynamic> json){
     leadingImage = json['leadingImage'];
     title = json['title'];
     subtitle = json['subtitle'];
     trailingImage = json['trailingImage'];
     isSystemComment = json['isSystemComment'];
     userId = json['userId'];
     uid = json['uid'];
     // convert date from timestamp to DateTime
     date =(json['date']as Timestamp).toDate();
       postId = json['postId'];
  }

  toJson() {
    return {
      'leadingImage': leadingImage,
      'title': title,
      'subtitle': subtitle,
      'trailingImage': trailingImage,
      'isSystemComment': isSystemComment,
      'userId': userId,
      'uid': uid ,
      'date': date ,
      'postId': postId,
    };
  }
}
