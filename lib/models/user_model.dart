import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  int age;
  String email;
  DateTime dob;
  String gender;
  String employmentStatus;
  String employeeAddress;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.dob,
    required this.gender,
    required this.employmentStatus,
    required this.employeeAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
      dob: (json['dob'] as Timestamp).toDate(),
      gender: json['gender'] as String,
      employmentStatus: json['employmentStatus'] as String,
      employeeAddress: json['employeeAddress'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'dob': Timestamp.fromDate(dob),
      'gender': gender,
      'employmentStatus': employmentStatus,
      'employeeAddress': employeeAddress,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    int? age,
    String? email,
    DateTime? dob,
    String? gender,
    String? employmentStatus,
    String? employeeAddress,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      employmentStatus: employmentStatus ?? this.employmentStatus,
      employeeAddress: employeeAddress ?? this.employeeAddress,
    );
  }
}
