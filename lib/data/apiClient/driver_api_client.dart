import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maseef_app/presentation/admin/drivers_management/model/driver.dart';

class DriverApiClient {

  FirebaseAuth firebaseAuth ;
  FirebaseFirestore firebaseFirestore ;


  DriverApiClient(this.firebaseAuth, this.firebaseFirestore);

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Future<bool> isSignedIn() async {
    return firebaseAuth.currentUser != null;
  }

  Future<Driver?> signIn(String email, String password) async {
    final authResult = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userId = authResult.user!.uid;
    final userData = await firebaseFirestore.collection('drivers').doc(userId).get();
    return Driver.fromJson(userData.data()!);
  }
 // share his location to firebase with his id
 Future<void> shareLocation(GeoPoint location) async {
    await firebaseFirestore.collection('drivers').doc(firebaseAuth.currentUser!.uid).update({
      'location': location,
    });
  }
}
