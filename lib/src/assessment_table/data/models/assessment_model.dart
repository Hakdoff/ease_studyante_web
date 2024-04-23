import 'package:ease_studyante_teacher_app/src/assessment_table/domain/entities/assessment.dart';
import 'package:equatable/equatable.dart';

class AssessmentModel extends Equatable {
  final String? nextPage;
  final int totalCount;
  final List<Assessment> assessments;

  const AssessmentModel({
    this.nextPage,
    required this.totalCount,
    required this.assessments,
  });

  @override
  List<Object?> get props => [nextPage, totalCount, assessments];

  AssessmentModel copyWith({
    String? nextPage,
    int? totalCount,
    List<Assessment>? assessments,
  }) {
    return AssessmentModel(
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      assessments: assessments ?? this.assessments,
    );
  }

  factory AssessmentModel.empty() =>
      const AssessmentModel(totalCount: -1, assessments: []);
}
