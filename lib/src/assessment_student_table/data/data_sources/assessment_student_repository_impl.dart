import 'dart:async';

import 'package:collection/collection.dart';
import 'package:ease_studyante_teacher_app/core/config/app_constant.dart';
import 'package:ease_studyante_teacher_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/data/models/student_assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/domain/entities/student_assessment.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/domain/repositories/assessment_student_repository.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';

class StudentAssessmentRepositoryImpl extends StudentAssessmentRepository {
  @override
  FutureOr<StudentAssessmentModel> getStudentAssessment({
    required String assessmentId,
    required String sectionId,
    required String subjectId,
    int limit = 70,
    String? studentName,
    String? nextPage,
  }) async {
    String url = '';
    String fields = 'assessment__pk';
    String values = '&assessment__pk=$assessmentId';

    if (nextPage == null) {
      url =
          '${AppConstant.apiUrl}/teacher/student/assessments?limit=$limit&search_fields=$fields$values';

      if (studentName != null) {
        url += '&student_name=$studentName';
      }
      url += '&subject_id=$subjectId';
      url += '&section_id=$sectionId';
    } else {
      url = nextPage;
    }

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      final assessments =
          results.map((e) => StudentAssessment.fromMap(e)).toList();
      return StudentAssessmentModel(
          assessments: assessments,
          nextPage: value.data['next'],
          totalCount: value.data['count']);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  StudentAssessmentModel initStudentAssessments({
    required StudentAssessmentModel studentAssessments,
    required List<Student> students,
  }) {
    if (studentAssessments.assessments.length == students.length ||
        studentAssessments.assessments.isEmpty) {
      return studentAssessments;
    }

    final List<StudentAssessment> assessments = [];
    final currentAssessment = studentAssessments.assessments.first.assessment;

    for (int i = 0; i < students.length; i++) {
      final student = students[i];
      final assessment = studentAssessments.assessments
          .firstWhereOrNull((e) => student.user.pk == e.student.user.pk);

      assessments.add(
        assessment ??
            StudentAssessment(
              id: '-1',
              obtainedMarks: '-1',
              assessment: currentAssessment,
              student: student,
              createdAt: '',
            ),
      );
    }

    return studentAssessments.copyWith(assessments: assessments);
  }

  @override
  FutureOr<StudentAssessment> saveStudentScore({
    required String id,
    required String assessmentId,
    required String studentId,
    required String obtainMarks,
  }) async {
    const url =
        '${AppConstant.apiUrl}/teacher/update-create-student-assessment';

    final data = {
      "id": id,
      "assessment_id": assessmentId,
      "student_id": studentId,
      "obtained_marks": obtainMarks,
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      return StudentAssessment.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
