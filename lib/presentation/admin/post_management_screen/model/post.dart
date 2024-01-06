import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Post extends Equatable {
  final String postId;
  final String adminId;
  final DateTime postDate;
  final String postContent;
  final LatLng postLocation;
  final String postImage;
  final String postTitle;

  Post({
    required this.postId,
    required this.adminId,
    required this.postDate,
    required this.postContent,
    required this.postLocation,
    required this.postImage,
    required this.postTitle,
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
      ];
}
