import 'package:ease_studyante_teacher_app/core/enum/assessment_type.dart';
import 'package:ease_studyante_teacher_app/core/enum/grading_period.dart';
import 'package:ease_studyante_teacher_app/core/enum/task_type.dart';
import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/domain/repositories/assessment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentRepository _repository;

  AssessmentBloc(this._repository)
      : super(AssessmentInitial(assessmentModel: AssessmentModel.empty())) {
    on<OnGetAssessmentEvent>(_onGetAssessmentEvent);
    on<OnSearchActivityName>(_onSearchActivityName);
    on<OnPaginateAssessmentEvent>(_onPaginateAssessmentEvent);
    on<OnFilterAssessmentEvent>(_onFilterAssessmentEvent);
    on<OnSortByName>(_onSortByName);
  }

  Future<void> _onSortByName(
      OnSortByName event, Emitter<AssessmentState> emit) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final searchName =
        event.activityName.trim().isNotEmpty ? event.activityName : null;

    final response = await _repository.getAssessment(
      subjectId: event.subjectId,
      name: searchName,
      assessmentType: event.assessmentType,
      gradingPeriod: event.gradingPeriod,
      taskType: event.taskType,
      isAscending: event.isAsceding,
    );

    emit(
      state.copyWith(
        assessmentModel: response,
        viewStatus: ViewStatus.successful,
        isAscending: event.isAsceding,
      ),
    );
  }

  Future<void> _onFilterAssessmentEvent(
      OnFilterAssessmentEvent event, Emitter<AssessmentState> emit) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final searchName =
        event.activityName.trim().isNotEmpty ? event.activityName : null;

    final response = await _repository.getAssessment(
      subjectId: event.subjectId,
      name: searchName,
      assessmentType: event.assessmentType,
      gradingPeriod: event.gradingPeriod,
      taskType: event.taskType,
    );

    emit(
      state.copyWith(
        assessmentModel: response,
        viewStatus: ViewStatus.successful,
        isAscending: event.isAsceding,
      ),
    );
  }

  Future<void> _onSearchActivityName(
      OnSearchActivityName event, Emitter<AssessmentState> emit) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final response = await _repository.getAssessment(
        subjectId: event.subjectId, name: event.activityName);

    emit(
      state.copyWith(
        assessmentModel: response,
        viewStatus: ViewStatus.successful,
        isAscending: event.isAsceding,
      ),
    );
  }

  Future<void> _onPaginateAssessmentEvent(
      OnPaginateAssessmentEvent event, Emitter<AssessmentState> emit) async {
    if (state.viewStatus == ViewStatus.successful &&
        state.assessmentModel.nextPage != null) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _repository.getAssessment(
        subjectId: event.subjectId,
        name: event.activityName.trim().isEmpty ? null : event.activityName,
      );

      emit(
        state.copyWith(
          assessmentModel: response.copyWith(
            assessments: [
              ...state.assessmentModel.assessments,
              ...response.assessments,
            ],
          ),
          viewStatus: ViewStatus.successful,
        ),
      );
    }
  }

  Future<void> _onGetAssessmentEvent(
      OnGetAssessmentEvent event, Emitter<AssessmentState> emit) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final response =
        await _repository.getAssessment(subjectId: event.subjectId);

    emit(
      state.copyWith(
        assessmentModel: response,
        viewStatus: ViewStatus.successful,
      ),
    );
  }
}
