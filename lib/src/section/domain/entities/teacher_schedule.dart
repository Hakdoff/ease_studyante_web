import 'dart:convert';

import 'package:ease_studyante_teacher_app/src/section/data/models/subject_model.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/section.dart';
import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String id;
  final SubjectModel subject;
  final Section section;
  final String day;
  final String timeStart;
  final String timeEnd;

  const Schedule({
    required this.id,
    required this.subject,
    required this.section,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
  });

  @override
  List<Object> get props {
    return [
      id,
      subject,
      section,
      day,
      timeStart,
      timeEnd,
    ];
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['id'] ?? '',
      subject: SubjectModel.fromMap(map['subject']),
      section: Section.fromMap(map['section']),
      day: map['day'] ?? '',
      timeStart: map['time_start'] ?? '',
      timeEnd: map['time_end'] ?? '',
    );
  }

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source));

  factory Schedule.empty() {
    return Schedule(
      day: '',
      id: '',
      section: Section.empty(),
      subject: SubjectModel.empty(),
      timeEnd: '07:00:00',
      timeStart: '07:00:00',
    );
  }
}
