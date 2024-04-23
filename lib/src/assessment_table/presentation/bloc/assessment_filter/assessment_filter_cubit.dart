import 'package:ease_studyante_teacher_app/core/enum/assessment_type.dart';
import 'package:ease_studyante_teacher_app/core/enum/grading_period.dart';
import 'package:ease_studyante_teacher_app/core/enum/task_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../assessment_filter_state.dart';

class AssessmentFilterCubit extends Cubit<AssessmentFilterState> {
  AssessmentFilterCubit()
      : super(
          AssessmentFilterState.initValues(),
        );

  void onChangedGradingPeriod(GradingPeriod? gradingPeriod) {
    emit(
      AssessmentFilterState.initValues().copyWith(
        selectedAssessmentType: state.selectedAssessmentType,
        selectedTaskType: state.selectedTaskType,
        selectedGradingPeriod: gradingPeriod,
      ),
    );
  }

  void onChangedTaskType(TaskType? taskType) {
    emit(
      AssessmentFilterState.initValues().copyWith(
        selectedAssessmentType: state.selectedAssessmentType,
        selectedTaskType: taskType,
        selectedGradingPeriod: state.selectedGradingPeriod,
      ),
    );
  }

  void onChangedAssessmentType(AssessmentType? assessmentType) {
    emit(
      AssessmentFilterState.initValues().copyWith(
        selectedAssessmentType: assessmentType,
        selectedTaskType: state.selectedTaskType,
        selectedGradingPeriod: state.selectedGradingPeriod,
      ),
    );
  }

  void resetFilters() {
    emit(
      AssessmentFilterState.initValues(),
    );
  }
}
