import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ease_studyante_teacher_app/src/section/domain/entities/user.dart';

class Parent extends Equatable {
  final User user;
  final String address;
  final String contactNumber;
  final int age;
  final String gender;
  final String? profilePhoto;

  const Parent({
    required this.user,
    required this.address,
    required this.contactNumber,
    required this.age,
    required this.gender,
    this.profilePhoto,
  });

  @override
  List<Object?> get props {
    return [
      user,
      address,
      contactNumber,
      age,
      gender,
      profilePhoto,
    ];
  }

  Parent copyWith({
    User? user,
    String? address,
    String? contactNumber,
    int? age,
    String? gender,
    String? yearLevel,
    String? profilePhoto,
    User? parent,
  }) {
    return Parent(
      user: user ?? this.user,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  factory Parent.fromMap(Map<String, dynamic> map) {
    return Parent(
      user: User.fromMap(map['user']),
      address: map['address'] ?? '',
      contactNumber: map['contact_number'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      profilePhoto: map['profile_photo'],
    );
  }

  factory Parent.fromJson(String source) => Parent.fromMap(json.decode(source));
}
