import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/data/apiClient/admin_api_client.dart';
import 'package:maseef_app/data/apiClient/driver_api_client.dart';
import 'package:maseef_app/data/apiClient/user_api_client.dart';
import 'package:maseef_app/data/remote_data_source/driver_remote_data_source.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';

import '../../data/remote_data_source/admin_remote_data_source.dart';

/// A class for setting up initial dependencies using GetX dependency injection.
///
/// This class extends the [Bindings] class and overrides the [dependencies]
/// method to register dependencies using GetX's [Get.put] method.
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Get.put(UserApiClient(auth, firestore));
    Get.put(AdminApiClient(auth, firestore));
    Get.put(DriverApiClient(auth, firestore));
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    Get.put(UserRemoteDataSourceImpl(Get.find(),Get.find()));
    Get.put(AdminRemoteDataSourceImpl(Get.find(),Get.find()));
    Get.put(DriverRemoteDataSourceImpl(Get.find(),Get.find()));
  }
}
