import 'dart:convert';

import 'package:ease_studyante_teacher_app/src/section/domain/entities/parent.dart';
import 'package:equatable/equatable.dart';

import 'package:ease_studyante_teacher_app/src/section/domain/entities/user.dart';

class Student extends Equatable {
  final String id;
  final User user;
  final String address;
  final String contactNumber;
  final int age;
  final String gender;
  final String lrn;
  final String yearLevel;
  final String? profilePhoto;
  final Parent? parent;

  const Student({
    required this.id,
    required this.user,
    required this.address,
    required this.contactNumber,
    required this.age,
    required this.gender,
    required this.lrn,
    required this.yearLevel,
    this.profilePhoto,
    this.parent,
  });

  @override
  List<Object?> get props {
    return [
      id,
      user,
      address,
      contactNumber,
      age,
      gender,
      lrn,
      yearLevel,
      profilePhoto,
    ];
  }

  Student copyWith({
    User? user,
    String? address,
    String? contactNumber,
    int? age,
    String? gender,
    String? lrn,
    String? yearLevel,
    String? profilePhoto,
    Parent? parent,
    String? id,
  }) {
    return Student(
      id: id ?? this.id,
      user: user ?? this.user,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      lrn: lrn ?? this.lrn,
      yearLevel: yearLevel ?? this.yearLevel,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      parent: parent ?? this.parent,
    );
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['pk'] as String,
      user: User.fromMap(map['user']),
      address: map['address'] ?? '',
      contactNumber: map['contact_number'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      lrn: map['lrn'] ?? '',
      yearLevel: map['year_level'] ?? '',
      profilePhoto: map['profile_photo'],
      parent: map['parent'] != null ? Parent.fromMap(map['parent']) : null,
    );
  }

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));
}
