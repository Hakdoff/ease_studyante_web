import 'dart:convert';

import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String id;
  final Schedule schedule;
  final Student student;
  final String date;
  final bool isPresent;

  const Attendance({
    required this.id,
    required this.schedule,
    required this.student,
    required this.date,
    this.isPresent = false,
  });

  Attendance copyWith({
    String? id,
    Schedule? schedule,
    Student? student,
    String? date,
    bool? isPresent,
  }) {
    return Attendance(
      id: id ?? this.id,
      schedule: schedule ?? this.schedule,
      student: student ?? this.student,
      date: date ?? this.date,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'] ?? '',
      schedule: Schedule.fromMap(map['schedule']),
      student: Student.fromMap(map['student']),
      date: map['date'] ?? '',
      isPresent: map['is_present'],
    );
  }

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      schedule,
      student,
      date,
      isPresent,
    ];
  }
}
