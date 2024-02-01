import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminApiClient {

  FirebaseAuth firebaseAuth;

  FirebaseFirestore firebaseFirestore;


  AdminApiClient(this.firebaseAuth, this.firebaseFirestore);

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    return firebaseAuth.currentUser != null;
  }

  Future<bool> signIn(String email, String password) async {
    var response = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return (await firebaseFirestore.collection('admin')
        .doc(response.user?.uid)
        .get()).exists;
  }
}