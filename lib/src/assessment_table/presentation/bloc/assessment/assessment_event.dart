part of 'assessment_bloc.dart';

abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object?> get props => [];
}

class OnGetAssessmentEvent extends AssessmentEvent {
  final String subjectId;

  const OnGetAssessmentEvent(this.subjectId);

  @override
  List<Object> get props => [
        subjectId,
      ];
}

class OnPaginateAssessmentEvent extends AssessmentEvent {
  final String activityName;
  final String subjectId;

  const OnPaginateAssessmentEvent({
    required this.activityName,
    required this.subjectId,
  });

  @override
  List<Object> get props => [
        activityName,
        subjectId,
      ];
}

class OnSearchActivityName extends AssessmentEvent {
  final String activityName;
  final String subjectId;
  final GradingPeriod? gradingPeriod;
  final AssessmentType? assessmentType;
  final TaskType? taskType;
  final bool? isAsceding;

  const OnSearchActivityName({
    required this.subjectId,
    required this.activityName,
    this.gradingPeriod,
    this.assessmentType,
    this.taskType,
    this.isAsceding,
  });

  @override
  List<Object?> get props => [
        activityName,
        subjectId,
        taskType,
        assessmentType,
        gradingPeriod,
        isAsceding,
      ];
}

class OnFilterAssessmentEvent extends AssessmentEvent {
  final String activityName;
  final String subjectId;
  final GradingPeriod? gradingPeriod;
  final AssessmentType? assessmentType;
  final TaskType? taskType;
  final bool? isAsceding;

  const OnFilterAssessmentEvent({
    required this.subjectId,
    required this.activityName,
    this.gradingPeriod,
    this.assessmentType,
    this.taskType,
    this.isAsceding,
  });

  @override
  List<Object?> get props => [
        activityName,
        subjectId,
        taskType,
        assessmentType,
        gradingPeriod,
        isAsceding,
      ];
}

class OnSortByName extends AssessmentEvent {
  final String activityName;
  final String subjectId;
  final GradingPeriod? gradingPeriod;
  final AssessmentType? assessmentType;
  final TaskType? taskType;
  final bool? isAsceding;

  const OnSortByName({
    required this.subjectId,
    required this.activityName,
    this.gradingPeriod,
    this.assessmentType,
    this.taskType,
    this.isAsceding,
  });

  @override
  List<Object?> get props => [
        activityName,
        subjectId,
        taskType,
        assessmentType,
        gradingPeriod,
        isAsceding,
      ];
}
