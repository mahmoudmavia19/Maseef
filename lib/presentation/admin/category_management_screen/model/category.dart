import 'package:equatable/equatable.dart';

class Category extends Equatable {
    String id;
  String name;
  DateTime createTime;

  Category({required this.id, required this.name, required this.createTime});

  @override
  List<Object?> get props => [id, name, createTime];

  // Convert Category object to a Map<String, dynamic> for serialization.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createTime': createTime.toIso8601String(), // Convert DateTime to String
    };
  }

  // Create a Category object from a Map<String, dynamic>.
  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      createTime: DateTime.parse(json['createTime']), // Parse String to DateTime
    );
  }
}
