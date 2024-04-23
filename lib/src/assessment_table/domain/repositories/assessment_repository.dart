import 'dart:async';

import 'package:ease_studyante_teacher_app/core/enum/assessment_type.dart';
import 'package:ease_studyante_teacher_app/core/enum/grading_period.dart';
import 'package:ease_studyante_teacher_app/core/enum/task_type.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/assessment_model.dart';

abstract class AssessmentRepository {
  FutureOr<AssessmentModel> getAssessment({
    required String subjectId,
    int limit = 70,
    String? name,
    GradingPeriod? gradingPeriod,
    AssessmentType? assessmentType,
    TaskType? taskType,
    String? nextPage,
    bool? isAscending,
  });
}
