part of 'assessment_bloc.dart';

class AssessmentState extends Equatable {
  final AssessmentModel assessmentModel;
  final ViewStatus viewStatus;
  final String? errorMessage;
  final bool? isAscending;

  const AssessmentState({
    required this.assessmentModel,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
    this.isAscending,
  });

  AssessmentState copyWith({
    ViewStatus? viewStatus,
    AssessmentModel? assessmentModel,
    String? errorMessage,
    bool? isAscending,
  }) {
    return AssessmentState(
      viewStatus: viewStatus ?? this.viewStatus,
      assessmentModel: assessmentModel ?? this.assessmentModel,
      errorMessage: errorMessage ?? this.errorMessage,
      isAscending: isAscending ?? this.isAscending,
    );
  }

  @override
  List<Object?> get props => [
        assessmentModel,
        viewStatus,
        errorMessage,
        isAscending,
      ];
}

final class AssessmentInitial extends AssessmentState {
  const AssessmentInitial({required super.assessmentModel});
}
