class NotificationModel {
  final String leadingImage;
  final String title;
  final String subtitle;
    String? trailingImage;
  final bool isSystemComment;

  NotificationModel({
    required this.leadingImage,
    required this.title,
    required this.subtitle,
      this.trailingImage,
    required this.isSystemComment,
  });
}
