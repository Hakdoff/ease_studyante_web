import 'dart:convert';

import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';
import 'package:equatable/equatable.dart';

class StudentListResponseModel extends Equatable {
  final List<Student> students;
  final String? nextPage;
  final int totalCount;

  const StudentListResponseModel({
    required this.students,
    this.nextPage,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [
        students,
        nextPage,
        totalCount,
      ];

  factory StudentListResponseModel.fromMap(Map<String, dynamic> map) {
    return StudentListResponseModel(
      students: List<Student>.from(
          map['results']?.map((x) => Student.fromMap(x['student']))),
      nextPage: map['next'],
      totalCount: map['count']?.toInt() ?? 0,
    );
  }

  StudentListResponseModel copyWith({
    List<Student>? students,
    String? nextPage,
    int? totalCount,
  }) {
    return StudentListResponseModel(
      students: students ?? this.students,
      totalCount: totalCount ?? this.totalCount,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  factory StudentListResponseModel.empty() =>
      const StudentListResponseModel(students: [], totalCount: -1);

  factory StudentListResponseModel.fromJson(String source) =>
      StudentListResponseModel.fromMap(json.decode(source));
}
