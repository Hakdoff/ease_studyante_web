import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/teacher_model.dart';
import 'package:ease_studyante_teacher_app/src/section/data/models/subject_model.dart';

class TeacherAssessmentItemModel {
  final String id;
  final String name;
  final String assessmentType;
  final String taskType;
  final String maxMark;
  final String gradingPeriod;

  final TeacherModel teacher;
  final SubjectModel subject;

  TeacherAssessmentItemModel({
    required this.id,
    required this.name,
    required this.assessmentType,
    required this.taskType,
    required this.maxMark,
    required this.gradingPeriod,
    required this.teacher,
    required this.subject,
  });

  factory TeacherAssessmentItemModel.fromMap(Map<String, dynamic> map) {
    return TeacherAssessmentItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      assessmentType: map['assessment_type'] as String,
      taskType: map['task_type'] as String,
      maxMark: map['max_marks'] as String,
      gradingPeriod: map['grading_period'] as String,
      subject: SubjectModel.fromMap(
        map['subject'] as Map<String, dynamic>,
      ),
      teacher: TeacherModel.fromMap(
        map['teacher'] as Map<String, dynamic>,
      ),
    );
  }
}
