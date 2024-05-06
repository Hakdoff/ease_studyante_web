import 'dart:async';

import 'package:ease_studyante_teacher_app/src/assessment_student_table/data/models/student_assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/domain/entities/student_assessment.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/domain/entities/assessment.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';

abstract class StudentAssessmentRepository {
  FutureOr<StudentAssessmentModel> getStudentAssessment({
    required String assessmentId,
    required String sectionId,
    required String subjectId,
    String? studentName,
    String? nextPage,
    int limit = 70,
  });

  StudentAssessmentModel initStudentAssessments({
    required StudentAssessmentModel studentAssessments,
    required List<Student> students,
    required Assessment assessment,
  });

  FutureOr<StudentAssessment> saveStudentScore({
    required String id,
    required String assessmentId,
    required String studentId,
    required String obtainMarks,
  });
}
