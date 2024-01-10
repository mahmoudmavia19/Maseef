// store_model.dart
import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String id;
  final String name;
  final String link;
  final String discountCode;
  final String photoUrl;
  bool accepted;


  Store({
    required this.id,
    required this.name,
    required this.link,
    required this.discountCode,
    required this.photoUrl,
    this.accepted = false,
  });

  Store copyWith({
    String? id,
    String? name,
    String? link,
    String? discountCode,
    String? photoUrl,
    bool? accepted,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      discountCode: discountCode ?? this.discountCode,
      photoUrl: photoUrl ?? this.photoUrl,
      accepted: accepted ?? this.accepted,
    );
  }

  @override
   List<Object?> get props => [
    id,
    name,
    link,
    discountCode,
    photoUrl,
    accepted,
  ];
}
