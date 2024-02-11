import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maseef_app/presentation/admin/bus_management_screen/model/bus.dart';
import 'package:maseef_app/presentation/admin/complaint_screen/model/complaint.dart';

import '../../presentation/admin/category_management_screen/model/category.dart';
import '../../presentation/admin/drivers_management/model/driver.dart';
import '../../presentation/admin/post_management_screen/model/post.dart';
import '../../presentation/admin/store_management_screen/model/store.dart';

class AdminApiClient {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  FirebaseStorage firebaseStorage;
  String? AdminId;

  AdminApiClient(this.firebaseAuth, this.firebaseFirestore, this.firebaseStorage);

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    AdminId = null;
  }

  Future<bool> isSignedIn() async {
    return AdminId!= null;
  }

  Future<bool> signIn(String email, String password) async {
    var response = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    AdminId = response.user?.uid;
    return (await firebaseFirestore.collection('admin')
        .doc(response.user?.uid)
        .get()).exists;
  }

  // refactor this to get image path and upload it make a post_image as default
  Future<String> uploadImage(File file, {String path ='post_images'}) async {
    var response = await firebaseStorage.ref('${path}/${XFile(file.path).name}').putFile(file);
    return await response.ref.getDownloadURL();
  }



  Future<void> addPost(Post post,File file) async {
    var imgUrlResponse =  await uploadImage(file) ;
    post.postImage = imgUrlResponse;
    post.adminId = AdminId;
    await firebaseFirestore.collection('posts').add(post.toJson());
  }

  Future<List<Post>> getPosts() async {
    var response = await firebaseFirestore.collection('posts').get();
    return response.docs.map((doc) {
      var post = Post.fromJson(doc.data());
      post.postId = doc.id;
      print(post.postId);
      return post;
    }).toList();
  }

  Future<void> deletePost(Post post) async {
    await firebaseFirestore.collection('posts').doc(post.postId).delete();
  }

  Future<void> editPost (Post post,File? file) async {
    if(file != null){
      var imgUrlResponse =  await uploadImage(file) ;
      post.postImage = imgUrlResponse;
    }
    await firebaseFirestore.collection('posts').doc(post.postId).update(post.toJson());
  }

  Future<void> addCategory(Category category) async {
       await firebaseFirestore.collection('categories').add(category.toJson());
  }
  Future<void> editCategory(Category category) async {
    await firebaseFirestore.collection('categories').doc(category.id).update(category.toJson());
  }
  Future<void> deleteCategory(Category category) async {
    await firebaseFirestore.collection('categories').doc(category.id).delete();
  }
  Future<List<Category>> getCategories() async {
    var response = await firebaseFirestore.collection('categories').get();
    return response.docs.map((doc) {
      var category = Category.fromJson(doc.data());
      category.id = doc.id;
      return category;
    }).toList();
  }
  Future<void> addBus(Bus bus) async{
    await firebaseFirestore.collection('buses').add(bus.toJson());
  }
  Future<List<Bus>> getBuses() async{
    var response = await firebaseFirestore.collection('buses').get();
    return response.docs.map((doc) {
      var bus = Bus.fromJson(doc.data());
      bus.id= doc.id;
      return bus;
    }) .toList();
  }
  Future<void> editBus(Bus bus) async{
    await firebaseFirestore.collection('buses').doc(bus.id).update(bus.toJson());
  }
  Future<void> deleteBus(Bus bus) async{
    await firebaseFirestore.collection('buses').doc(bus.id).delete();
  }

  Future<void> addDriver(Driver driver,String password) async{
       var response = await firebaseAuth.createUserWithEmailAndPassword(
            email: driver.email,
            password: password,
          );
    driver.id = response.user?.uid;
    await firebaseFirestore.collection('drivers').doc(driver.id).set(driver.toJson());
    firebaseAuth.signOut();
  }

  Future<List<Driver>> getDrivers() async{
    var response = await firebaseFirestore.collection('drivers').get();
    return response.docs.map((doc) {
      return Driver.fromJson(doc.data());
    }).toList();
  }

  Future<void> editDriver(Driver driver) async{
    await firebaseFirestore.collection('drivers').doc(driver.id).update(driver.toJson());
  }

  Future<void> deleteDriver(Driver driver) async{
    await firebaseFirestore.collection('drivers').doc(driver.id).delete();
  }

  Future<void> addStore(Store store , File file) async{
    var imgUrlResponse =  await uploadImage(file,path: 'store_images') ;
    store.photoUrl = imgUrlResponse;
    await firebaseFirestore.collection('stores').add(store.toJson());
  }
  Future<void> editStore(Store store) async{
    await firebaseFirestore.collection('stores').doc(store.id).update(store.toJson());
  }
  Future<List<Store>> getStores() async{
    var response = await firebaseFirestore.collection('stores').get();
    return response.docs.map((doc) {
      var store = Store.fromJson(doc.data());
      store.id= doc.id;
      return store;
    }).toList();
  }
  Future<List<Complaint>> getComplaints() async{
     var response = await firebaseFirestore.collection('complaints').get();
    return response.docs.map((doc) {
      var c = Complaint.fromJson(doc.data());
      c.id= doc.id;
      return c;
    }).toList();
  }

  Future<void> responseComplaint(Complaint complaint) async{
    await firebaseFirestore.collection('complaints').doc(complaint.id).update(complaint.toJson());
  }
}
