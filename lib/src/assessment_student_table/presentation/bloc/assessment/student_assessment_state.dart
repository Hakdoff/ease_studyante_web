part of 'student_assessment_bloc.dart';

class StudentAssessmentState extends Equatable {
  final StudentAssessmentModel studentAssessmentModel;
  final StudentListResponseModel studentListResponseModel;
  final ViewStatus viewStatus;
  final String? errorMessage;
  final bool isOnSaveScore;

  const StudentAssessmentState({
    required this.studentAssessmentModel,
    required this.studentListResponseModel,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
    this.isOnSaveScore = false,
  });

  StudentAssessmentState copyWith({
    ViewStatus? viewStatus,
    StudentAssessmentModel? studentAssessmentModel,
    String? errorMessage,
    StudentListResponseModel? studentListResponseModel,
    bool? isOnSaveScore,
  }) {
    return StudentAssessmentState(
      isOnSaveScore: isOnSaveScore ?? this.isOnSaveScore,
      viewStatus: viewStatus ?? this.viewStatus,
      studentAssessmentModel:
          studentAssessmentModel ?? this.studentAssessmentModel,
      errorMessage: errorMessage ?? this.errorMessage,
      studentListResponseModel:
          studentListResponseModel ?? this.studentListResponseModel,
    );
  }

  @override
  List<Object?> get props => [
        studentAssessmentModel,
        studentListResponseModel,
        viewStatus,
        errorMessage,
        isOnSaveScore,
      ];
}

final class AssessmentInitial extends StudentAssessmentState {
  const AssessmentInitial({
    required super.studentAssessmentModel,
    required super.studentListResponseModel,
  });
}
