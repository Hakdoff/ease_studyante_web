import 'package:ease_studyante_teacher_app/src/section/data/models/subject_model.dart';
import 'package:equatable/equatable.dart';

class Assessment extends Equatable {
  final String id;
  final String name;
  final String assessmentType;
  final String taskType;
  final String maxMark;
  final String gradingPeriod;
  final String createdAt;

  final SubjectModel subject;

  const Assessment({
    required this.id,
    required this.name,
    required this.assessmentType,
    required this.taskType,
    required this.maxMark,
    required this.gradingPeriod,
    required this.subject,
    required this.createdAt,
  });

  factory Assessment.fromMap(Map<String, dynamic> map) {
    return Assessment(
        id: map['id'] as String,
        name: map['name'] as String,
        assessmentType: map['assessment_type'] as String,
        taskType: map['task_type'] as String,
        maxMark: map['max_marks'] as String,
        gradingPeriod: map['grading_period'] as String,
        subject: SubjectModel.fromMap(
          map['subject'] as Map<String, dynamic>,
        ),
        createdAt: map['created_at'] as String);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        assessmentType,
        taskType,
        maxMark,
        gradingPeriod,
        subject,
      ];
}
