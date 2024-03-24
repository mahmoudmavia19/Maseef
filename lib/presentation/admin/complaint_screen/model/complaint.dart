import 'dart:convert';

class Complaint {
  String? id;
  String? customerId;
  String? customerName;
  String? description;
  String? response;
  DateTime? responseDate;
  DateTime? createTime;

  Complaint({
   this.id,
   this.customerId,
   this.customerName,
   this.description,
   this.response,
   this.responseDate,
   this.createTime,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      description: json['description'],
      response: json['response'],
      responseDate: json['responseDate'] == null? null :DateTime.parse(json['responseDate']),
      createTime: DateTime.parse(json['createTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'description': description,
      'response': response,
      'responseDate': responseDate?.toIso8601String(),
      'createTime': createTime?.toIso8601String(),
    };
  }
}
