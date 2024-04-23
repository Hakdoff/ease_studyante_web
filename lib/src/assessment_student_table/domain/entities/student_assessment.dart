import 'package:ease_studyante_teacher_app/src/assessment_table/domain/entities/assessment.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';

class StudentAssessment {
  final String id;
  final String obtainedMarks;
  final Assessment assessment;
  final Student student;
  final String createdAt;

  StudentAssessment({
    required this.id,
    required this.obtainedMarks,
    required this.assessment,
    required this.student,
    required this.createdAt,
  });

  factory StudentAssessment.fromMap(Map<String, dynamic> map) {
    return StudentAssessment(
        id: map['pk'] as String,
        obtainedMarks: map['obtained_marks'] as String,
        assessment: Assessment.fromMap(
          map['assessment'] as Map<String, dynamic>,
        ),
        student: Student.fromMap(
          map['student'] as Map<String, dynamic>,
        ),
        createdAt: map['created_at'] as String);
  }

  StudentAssessment copyWith({
    String? id,
    String? obtainedMarks,
    Assessment? assessment,
    Student? student,
    String? createdAt,
  }) {
    return StudentAssessment(
      id: id ?? this.id,
      obtainedMarks: obtainedMarks ?? this.obtainedMarks,
      assessment: assessment ?? this.assessment,
      student: student ?? this.student,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
