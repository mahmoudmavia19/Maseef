// driver_model.dart

import '../../../../data/models/user/user.dart';

class Driver extends User {
  Driver({
    required String id,
    required String name,
    required int age,
    required String gender,
    required String phone,
    required String email,
  }) : super(
    id: id,
    name: name,
    age: age,
    gender: gender,
    phone: phone,
    email: email,
  );
}
