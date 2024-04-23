import 'package:ease_studyante_teacher_app/src/assessment_student_table/domain/entities/student_assessment.dart';
import 'package:equatable/equatable.dart';

class StudentAssessmentModel extends Equatable {
  final String? nextPage;
  final int totalCount;
  final List<StudentAssessment> assessments;

  const StudentAssessmentModel({
    this.nextPage,
    required this.totalCount,
    required this.assessments,
  });

  @override
  List<Object?> get props => [nextPage, totalCount, assessments];

  StudentAssessmentModel copyWith({
    String? nextPage,
    int? totalCount,
    List<StudentAssessment>? assessments,
  }) {
    return StudentAssessmentModel(
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      assessments: assessments ?? this.assessments,
    );
  }

  factory StudentAssessmentModel.empty() =>
      const StudentAssessmentModel(totalCount: -1, assessments: []);
}
