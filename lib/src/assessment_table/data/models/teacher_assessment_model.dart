import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/teacher_assessment_item_model.dart';

class TeacherAssessmentModel {
  final String obtainedMarks;
  final TeacherAssessmentItemModel assessment;

  TeacherAssessmentModel({
    required this.obtainedMarks,
    required this.assessment,
  });

  factory TeacherAssessmentModel.fromMap(Map<String, dynamic> map) {
    return TeacherAssessmentModel(
      obtainedMarks: map['obtained_marks'] as String,
      assessment: TeacherAssessmentItemModel.fromMap(
        map['assessment'] as Map<String, dynamic>,
      ),
    );
  }
}
