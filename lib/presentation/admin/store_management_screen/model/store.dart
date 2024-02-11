import 'package:equatable/equatable.dart';

class Store extends Equatable {
    String? id;
  final String name;
  final String link;
  final String discountCode;
    String? photoUrl;
  bool? accepted;

  Store({
      this.id,
    required this.name,
    required this.link,
    required this.discountCode,
      this.photoUrl,
    this.accepted,
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

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      discountCode: json['discountCode'],
      photoUrl: json['photoUrl'],
      accepted: json['accepted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'discountCode': discountCode,
      'photoUrl': photoUrl,
      'accepted': accepted,
    };
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
