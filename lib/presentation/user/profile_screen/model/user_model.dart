// user_model.dart
class UserModel {
    String id;
    String name;
    String username;
    int age;
    String email;
    String gender;
    String phoneNumber;
    String imagePath; // Add this field

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.age,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.imagePath, // Update the constructor
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      age: json['age'] ?? 0,
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      imagePath: json['imagePath'] ?? 'assets/images/user_placeholder.png', // Provide a default placeholder path
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'age': age,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'imagePath': imagePath,
    };
  }
}
