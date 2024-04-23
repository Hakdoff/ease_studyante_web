import 'package:ease_studyante_teacher_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/spaced_row_widget.dart';
import 'package:ease_studyante_teacher_app/core/extensions/string_extension.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/teacher_assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/section/data/models/subject_model.dart';
import 'package:ease_studyante_teacher_app/src/subject/data/blocs/bloc/subject_detail_bloc.dart';
import 'package:ease_studyante_teacher_app/src/subject/domain/models/student_overall_grade_model.dart';
import 'package:ease_studyante_teacher_app/src/subject/presentation/widgets/grading_detail_screen.dart';
import 'package:flutter/material.dart';

class GradingItemWidget extends StatelessWidget {
  final TeacherAssessmentModel assessment;
  final SubjectDetailBloc subjectDetailBloc;
  final SubjectModel subject;
  final StudentOverallGradeModel studentGrade;

  const GradingItemWidget({
    super.key,
    required this.assessment,
    required this.subjectDetailBloc,
    required this.subject,
    required this.studentGrade,
  });

  @override
  Widget build(BuildContext context) {
    final gradingPeriod = assessment.assessment.gradingPeriod.split('_');
    String gradingPeriodTitle = '';
    for (var element in gradingPeriod) {
      gradingPeriodTitle += '${element.capitalize()} ';
    }

    String gpa = '';

    switch (assessment.assessment.gradingPeriod) {
      case 'FIRST_GRADING':
        gpa = studentGrade.firstGrading;
        break;
      case 'SECOND_GRADING':
        gpa = studentGrade.secondGrading;
        break;
      case 'THIRD_GRADING':
        gpa = studentGrade.thirdGrading;
        break;
      case 'FOURTH_GRADING':
        gpa = studentGrade.fourthGrading;
        break;
      default:
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          GradingDetailScreen.routeName,
          arguments: GradingDetailScreenArgs(
            assessment: assessment,
            gradingPeriodTitle: gradingPeriodTitle,
            subjectDetailBloc: subjectDetailBloc,
            subject: subject,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: SpacedColumn(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: ColorName.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
              ),
              child: SpacedRow(
                children: [
                  Text(
                    gradingPeriodTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    gpa,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF494E56).withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    )
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      5,
                    ),
                  ),
                ),
                child: const Text(
                  'View Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
