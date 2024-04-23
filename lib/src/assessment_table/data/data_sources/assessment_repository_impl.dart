import 'dart:async';

import 'package:ease_studyante_teacher_app/core/config/app_constant.dart';
import 'package:ease_studyante_teacher_app/core/enum/assessment_type.dart';
import 'package:ease_studyante_teacher_app/core/enum/grading_period.dart';
import 'package:ease_studyante_teacher_app/core/enum/task_type.dart';
import 'package:ease_studyante_teacher_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/domain/entities/assessment.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/domain/repositories/assessment_repository.dart';

class AssessmentRepositoryImpl extends AssessmentRepository {
  @override
  FutureOr<AssessmentModel> getAssessment({
    required String subjectId,
    int limit = 100,
    String? name,
    GradingPeriod? gradingPeriod,
    AssessmentType? assessmentType,
    TaskType? taskType,
    String? nextPage,
    bool? isAscending,
  }) async {
    String url = '';
    String fields = 'subject__pk';
    String values = subjectId;

    if (nextPage == null) {
      if (gradingPeriod != null) {
        values += ',${gradingPeriod.name}';
        fields += ',grading_period';
      }

      if (assessmentType != null) {
        values += ',${assessmentType.name}';
        fields += ',assessment_type';
      }
      if (taskType != null) {
        values += ',${taskType.name}';
        fields += ',task_type';
      }

      url =
          '${AppConstant.apiUrl}/teacher/web/assessments?search_fields=$fields&search_values=$values&page_size=$limit';

      if (name != null) {
        url += '&name=$name';
      }

      if (isAscending != null) {
        url += '&ordering=${isAscending ? '' : '-'}name';
      }
    } else {
      url = nextPage;
    }

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      final assessments = results.map((e) => Assessment.fromMap(e)).toList();
      return AssessmentModel(
          assessments: assessments,
          nextPage: value.data['next'],
          totalCount: value.data['count']);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
