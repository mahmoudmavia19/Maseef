class NotificationModel {
  String? uid ;
  String? userId ;
  String? leadingImage;
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
    this.uid

  });

  NotificationModel.fromJson(Map<String, dynamic> json){
     leadingImage = json['leadingImage'];
     title = json['title'];
     subtitle = json['subtitle'];
     trailingImage = json['trailingImage'];
     isSystemComment = json['isSystemComment'];
     userId = json['userId'];
     uid = json['uid'];
  }

  toJson() {
    return {
      'leadingImage': leadingImage,
      'title': title,
      'subtitle': subtitle,
      'trailingImage': trailingImage,
      'isSystemComment': isSystemComment,
      'userId': userId,
      'uid': uid
    };
  }
}
