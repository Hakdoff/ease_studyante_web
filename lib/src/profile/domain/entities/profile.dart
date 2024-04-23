import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String pk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String? profilePhoto;

  const Profile({
    required this.pk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    this.profilePhoto,
  });

  Profile copyWith({
    String? pk,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? department,
    String? profilePhoto,
  }) {
    return Profile(
      pk: pk ?? this.pk,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      department: department ?? this.department,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'username': username});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'department': department});
    if (profilePhoto != null) {
      result.addAll({'profilePhoto': profilePhoto});
    }

    return result;
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      pk: map['pk'] ?? '',
      username: map['username'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      department: map['department'] ?? '',
      profilePhoto: map['profilePhoto'],
    );
  }

  factory Profile.chatFromMap(Map<String, dynamic> map) {
    return Profile(
      pk: map['user']['pk'] ?? '',
      username: map['user']['username'] ?? '',
      firstName: map['user']['first_name'] ?? '',
      lastName: map['user']['last_name'] ?? '',
      email: map['user']['email'] ?? '',
      department: map['department'] ?? '',
      profilePhoto: map['profilePhoto'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  factory Profile.empty() => const Profile(
        department: '',
        email: '',
        firstName: '',
        lastName: '',
        pk: '',
        username: '',
      );

  @override
  List<Object?> get props => [
        pk,
        username,
        firstName,
        lastName,
        email,
        department,
        profilePhoto,
      ];
}
