import 'package:get/get.dart';

import '../model/post.dart';

class PostController extends GetxController {
  final posts = <Post>[].obs;

  void addPost(Post post) {
    posts.add(post);
  }

  void editPost(Post oldPost, Post newPost) {
    final index = posts.indexWhere((element) => element.postId == oldPost.postId);
    if (index != -1) {
      posts[index] = newPost;
    }
  }

  void deletePost(Post post) {
    posts.remove(post);
  }
}
