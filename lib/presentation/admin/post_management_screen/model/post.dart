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
  final String? category;
    String postImage;
  final String postTitle;
  bool love;
  List<String> lovers = [];
 
  Post({
     this.postId,
     this.adminId,
    required this.postDate,
    required this.postContent,
    required this.postLocation,
    required this.postImage,
    required this.postTitle,
    required this.addressLocation,
    required this.category,
    this.love = false,
    this.lovers = const [],
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
    lovers,

  ];

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'adminId': adminId,
      'postDate': postDate.toIso8601String(),
      'postContent': postContent,
      'category': category,
      'postLocation': {
        'latitude': postLocation.latitude,
        'longitude': postLocation.longitude,
      },
      'addressLocation': addressLocation,
      'postImage': postImage,
      'postTitle': postTitle,
       'lovers': lovers,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      adminId: json['adminId'],
      category: json['category'],
      postDate: DateTime.parse(json['postDate']),
      postContent: json['postContent'],
      postLocation: LatLng(
        json['postLocation']['latitude'],
        json['postLocation']['longitude'],
      ),
      addressLocation: json['addressLocation'],
      postImage: json['postImage'],
      postTitle: json['postTitle'],
       lovers: List<String>.from(json['lovers']??[]),
    );
  }
}
