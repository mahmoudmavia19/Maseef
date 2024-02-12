import 'package:flutter/foundation.dart';

class Comment {
  final String id;
  final String userId;
  final String postId;
   final String comment;
  final DateTime date;
  final List<String> lovers;
  final List<Comment> replies;

  Comment({
     required this.id,
     required this.userId,
     required this.postId,
      required this.comment,
     required this.date,
    this.lovers = const [],
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      postId: json['postId'],
       comment: json['comment'],
      date: DateTime.parse(json['date']),
      lovers: List<String>.from(json['lovers']),
      replies: (json['replies'] as List<dynamic>)
          .map((replyJson) => Comment.fromJson(replyJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'postId': postId,
     'comment': comment,
    'date': date.toIso8601String(),
    'lovers': lovers,
    'replies': replies.map((reply) => reply.toJson()).toList(),
  };
}
