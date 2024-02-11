import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Post extends Equatable {
   String? postId;
   String? adminId;
  final DateTime postDate;
  final String postContent;
  final LatLng postLocation;
  final String addressLocation;
    String postImage;
  final String postTitle;
  bool love;

  Post({
     this.postId,
     this.adminId,
    required this.postDate,
    required this.postContent,
    required this.postLocation,
    required this.postImage,
    required this.postTitle,
    required this.addressLocation,
    this.love = false,
  });

  @override
  List<Object?> get props => [
    postId,
    adminId,
    postDate,
    postContent,
    postLocation,
    postImage,
    postTitle,
    addressLocation,
    love,
  ];

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'adminId': adminId,
      'postDate': postDate.toIso8601String(),
      'postContent': postContent,
      'postLocation': {
        'latitude': postLocation.latitude,
        'longitude': postLocation.longitude,
      },
      'addressLocation': addressLocation,
      'postImage': postImage,
      'postTitle': postTitle,
      'love': love,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      adminId: json['adminId'],
      postDate: DateTime.parse(json['postDate']),
      postContent: json['postContent'],
      postLocation: LatLng(
        json['postLocation']['latitude'],
        json['postLocation']['longitude'],
      ),
      addressLocation: json['addressLocation'],
      postImage: json['postImage'],
      postTitle: json['postTitle'],
      love: json['love'],
    );
  }
}
