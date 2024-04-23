import 'dart:async';

import 'package:ease_studyante_teacher_app/core/enum/grading_period.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/teacher_assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/subject/domain/models/student_overall_grade_model.dart';

abstract class TeacherAssessmentRepository {
  Future<List<TeacherAssessmentModel>> getAssessment({
    required GradingPeriod gradingPeriod,
    required String subjectId,
  });

  Future<List<TeacherAssessmentModel>> getAssessmentTeacher({
    required GradingPeriod gradingPeriod,
    required String studentId,
  });

  Future<StudentOverallGradeModel> getOverallGradeStudent({
    required String subjectId,
  });

  Future<StudentOverallGradeModel> getOverallGradeStudentTeacher({
    required String subjectId,
    required String studentId,
  });
}
