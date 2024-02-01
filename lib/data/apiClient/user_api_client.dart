import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

class UserApiClient {

  FirebaseAuth firebaseAuth ;
  FirebaseFirestore firebaseFirestore ;


  UserApiClient(this.firebaseAuth, this.firebaseFirestore);

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
      firebaseFirestore.collection('users').doc(value.user!.uid).set(
        user.toJson()
      );
      user.id =value.user!.uid;
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

}