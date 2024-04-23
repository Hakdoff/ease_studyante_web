part of 'assessment_filter/assessment_filter_cubit.dart';

class AssessmentFilterState extends Equatable {
  final List<GradingPeriod> gradingPeriods;
  final List<AssessmentType> assessmentTypes;
  final List<TaskType> taskTypes;
  final GradingPeriod? selectedGradingPeriod;
  final AssessmentType? selectedAssessmentType;
  final TaskType? selectedTaskType;

  const AssessmentFilterState({
    required this.gradingPeriods,
    required this.assessmentTypes,
    required this.taskTypes,
    this.selectedGradingPeriod,
    this.selectedAssessmentType,
    this.selectedTaskType,
  });

  AssessmentFilterState copyWith({
    List<GradingPeriod>? gradingPeriods,
    List<AssessmentType>? assessmentTypes,
    List<TaskType>? taskTypes,
    GradingPeriod? selectedGradingPeriod,
    AssessmentType? selectedAssessmentType,
    TaskType? selectedTaskType,
  }) {
    return AssessmentFilterState(
      gradingPeriods: gradingPeriods ?? this.gradingPeriods,
      assessmentTypes: assessmentTypes ?? this.assessmentTypes,
      taskTypes: taskTypes ?? this.taskTypes,
      selectedGradingPeriod:
          selectedGradingPeriod ?? this.selectedGradingPeriod,
      selectedAssessmentType:
          selectedAssessmentType ?? this.selectedAssessmentType,
      selectedTaskType: selectedTaskType ?? this.selectedTaskType,
    );
  }

  factory AssessmentFilterState.initValues() => const AssessmentFilterState(
        assessmentTypes: [
          AssessmentType.WRITTEN_WORKS,
          AssessmentType.PERFORMANCE_TASK,
          AssessmentType.QUARTERLY_ASSESSMENT,
        ],
        gradingPeriods: [
          GradingPeriod.FIRST_GRADING,
          GradingPeriod.SECOND_GRADING,
          GradingPeriod.THIRD_GRADING,
          GradingPeriod.FOURTH_GRADING,
        ],
        taskTypes: [
          TaskType.ASSIGNMENT,
          TaskType.QUIZ,
          TaskType.PROJECT,
          TaskType.EXAM,
        ],
      );

  @override
  List<Object?> get props {
    return [
      gradingPeriods,
      assessmentTypes,
      taskTypes,
      selectedGradingPeriod,
      selectedAssessmentType,
      selectedTaskType,
    ];
  }
}
