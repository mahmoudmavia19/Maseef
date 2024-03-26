

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maseef_app/presentation/admin/complaint_screen/model/complaint.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';
import 'package:maseef_app/presentation/user/notification_screen/model/notification_model.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

import '../../presentation/admin/post_management_screen/model/comment.dart';

class UserApiClient {

  FirebaseAuth firebaseAuth ;
  FirebaseFirestore firebaseFirestore ;
  FirebaseStorage firebaseStorage ;


  UserApiClient(this.firebaseAuth, this.firebaseFirestore , this.firebaseStorage);

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Future<bool> isSignedIn() async {
    return firebaseAuth.currentUser != null;
  }

  Future<UserModel> signUp(UserModel user, String password) async {
     await firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: password).then((value){
      user.id = value.user!.uid;
      firebaseFirestore.collection('users').doc(value.user!.uid).set(
        user.toJson()
      );
     });
     return user;
  }

  Future<UserModel?> signIn(String email, String password) async {
      final authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = authResult.user!.uid;
      final userData = await firebaseFirestore.collection('users').doc(userId).get();
      return UserModel.fromJson(userData.data()!);
  }


  Future<void> forgetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email,);
  }

  Future<List<Post>> getAllPosts () async {
    var result = await  firebaseFirestore.collection('posts').get();
    return result.docs.map((e) {
      var post = Post.fromJson(e.data());
      post.postId = e.id;
      post.love = post.lovers.contains(firebaseAuth.currentUser!.uid);
      return post;
    }).toList();
  }

  Future<void> likeOrDislikePost(Post post) async {
    if(post.lovers.contains(firebaseAuth.currentUser!.uid)) {
      post.lovers.remove(firebaseAuth.currentUser!.uid);
    } else {
      post.lovers.add(firebaseAuth.currentUser!.uid);
    }
    await firebaseFirestore.collection('posts').doc(post.postId).update(post.toJson());
  }

  Future<List<Comment>> getComments(String postId) async {
    var result = await firebaseFirestore.collection('posts').doc(postId).collection('comments').get();
    return result.docs.map((e) {
      var comment = Comment.fromJson(e.data());
      comment.id = e.id;
      comment.love = comment.lovers.contains(firebaseAuth.currentUser!.uid);
      return comment;
    }).toList();
  }

  Future<void> addComment(Comment comment) async {
    comment.userId = firebaseAuth.currentUser?.uid;
    await firebaseFirestore.collection('posts').doc(comment.postId).collection('comments').add(comment.toJson());
  }

  Future<UserModel> getUser(String userID) async {
    var result = await firebaseFirestore.collection('users').doc(userID).get();
    var user = UserModel.fromJson(result.data()!);
    user.id = userID;
    return user;
  }
  Future<List<Post>> getLoversPosts () async {
    var result = await firebaseFirestore.collection('posts').where('lovers', arrayContains: firebaseAuth.currentUser!.uid).get();
    return result.docs.map((e) => Post.fromJson(e.data())).toList();
  }

  Future<List<Store>> getStores () async {
    var result = await firebaseFirestore.collection('stores').where('accepted', isEqualTo: true).get();
    return result.docs.map((e) => Store.fromJson(e.data())).toList();
  }

  Future<void> addStore(Store store,File file) async {
    var storageRef = firebaseStorage.ref().child('stores/${XFile(file.path).name}');
    var uploadTask = storageRef.putFile(file);
    var snapshot = await uploadTask;
    store.photoUrl = await snapshot.ref.getDownloadURL();
    await firebaseFirestore.collection('stores').add(store.toJson());
  }

  Future<List<NotificationModel>> getNotifications() async {
    var result = await firebaseFirestore.collection('notifications').where('userId',isEqualTo:firebaseAuth.currentUser?.uid).get();
    return result.docs.map((e) => NotificationModel.fromJson(e.data())).toList();
  }

  Future<UserModel> getProfile() async {
    var result = await firebaseFirestore.collection('users').doc(firebaseAuth.currentUser!.uid).get();
    return UserModel.fromJson(result.data()!);
  }

  Future<void> updateProfile(UserModel user,XFile? file) async {
    if(file != null){
      var storageRef = firebaseStorage.ref().child('users/${file.name}');
      var uploadTask = storageRef.putFile(File(file.path));
      var snapshot = await uploadTask;
      user.imagePath = await snapshot.ref.getDownloadURL();
    }
    user.id = firebaseAuth.currentUser!.uid;
    await firebaseFirestore.collection('users').doc(firebaseAuth.currentUser!.uid).update(user.toJson());
  }

  Future<void> sendComplaint(Complaint complaint) async {
    await firebaseFirestore.collection('complaints').add(complaint.toJson());
   }
   Future<List<Complaint>> getComplaints() async {
    var result = await firebaseFirestore.collection('complaints').where('customerId',isEqualTo:firebaseAuth.currentUser?.uid).get();
    return result.docs.map((e) => Complaint.fromJson(e.data())).toList();
   }

   Future<List<Comment>> getPostComments()async {
    List<Comment> comments = [];
     var postResult = await firebaseFirestore.collection('posts').get() ;
     for(var posts in postResult.docs){
       var result = await firebaseFirestore.collection('posts').doc(posts.id).collection('comments').get();
       comments = result.docs.map((e) {
         var comment = Comment.fromJson(e.data());
         comment.id = posts.id;
         comment.love = comment.lovers.contains(firebaseAuth.currentUser!.uid);
         return Comment.fromJson(e.data());
       }).toList();
     }
     return comments;
   }

   Future<void> likeOrDislikeComment (Comment comment) async {
    if(comment.lovers.contains(firebaseAuth.currentUser!.uid)) {
      comment.lovers.remove(firebaseAuth.currentUser!.uid);
    } else {
      comment.lovers.add(firebaseAuth.currentUser!.uid);
    }
    await firebaseFirestore.collection('posts').doc(comment.postId).collection('comments').doc(comment.id).update(comment.toJson());
   }

}