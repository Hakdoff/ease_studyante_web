import 'package:data_table_2/data_table_2.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/common_dialog.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/shimmer.dart';
import 'package:ease_studyante_teacher_app/core/config/app_constant.dart';
import 'package:ease_studyante_teacher_app/core/extensions/string_extension.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/domain/entities/student_assessment.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/presentation/bloc/assessment/student_assessment_bloc.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/presentation/widgets/score_input_field.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentAssessmentListView extends StatefulWidget {
  const StudentAssessmentListView({
    super.key,
    required this.scrollController,
    required this.isPaginate,
    required this.students,
    this.isEncodeEnable = false,
  });

  final ScrollController scrollController;
  final bool isPaginate;
  final List<StudentAssessment> students;
  final bool isEncodeEnable;

  @override
  State<StudentAssessmentListView> createState() =>
      _StudentAssessmentListViewState();
}

class _StudentAssessmentListViewState extends State<StudentAssessmentListView> {
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      clipBehavior: Clip.hardEdge,
      scrollController: widget.scrollController,
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      headingRowDecoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: ColorName.primary,
      ),
      headingTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      columns: [
        DataColumn2(
          fixedWidth: 50,
          numeric: true,
          onSort: (columnIndex, ascending) {},
          label: const FittedBox(
            child: Text(
              '#',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn2(
          onSort: (columnIndex, ascending) {},
          label: const FittedBox(
            child: Text(
              'Student',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          // fixedWidth: 120,
          label: FittedBox(
            child: Text(
              'Year Level',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn2(
          onSort: (columnIndex, ascending) {},
          label: const FittedBox(
            child: Text(
              'Assessment Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          fixedWidth: 85,
          label: FittedBox(
            child: Text(
              'Status',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          label: FittedBox(
            child: Text(
              'Score',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        // const DataColumn2(
        //   fixedWidth: 120,
        //   label: FittedBox(
        //     child: Text(
        //       'Action',
        //       style: TextStyle(fontStyle: FontStyle.italic),
        //     ),
        //   ),
        // ),
      ],
      rows: dataRows(context),
    );
  }

  List<DataRow> dataRows(BuildContext context) {
    List<TextEditingController> controllers = List.generate(
        widget.students.length, (index) => TextEditingController());
    List<DataRow> widgets = [];
    List<Widget> status = [];
    try {
      for (var i = 0; i < widget.students.length; i++) {
        final e = widget.students[i];
        controllers[i].text = e.obtainedMarks == "-1" ? '' : e.obtainedMarks;
        status.add(
          e.obtainedMarks == "-1" ||
                  !isValidGrade(
                      currentScore: double.parse(e.obtainedMarks),
                      totalScore: double.parse(e.assessment.maxMark))
              ? const Text(
                  'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              : passedText(e),
        );
        final dataRow = DataRow(
          color: MaterialStateProperty.all(Colors.white),
          cells: [
            DataCell(Text('${widget.students.indexOf(e) + 1}')),
            DataCell(
              Text('${e.student.user.firstName} ${e.student.user.lastName}'),
            ),
            DataCell(
              Text(e.student.yearLevel),
            ),
            DataCell(
              Text(e.assessment.assessmentType.toEnumString()),
            ),
            DataCell(
              status[i],
            ),
            DataCell(
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ScoreInputField(
                  readOnly: widget.isEncodeEnable,
                  controller: controllers[i],
                  isError: !isValidGrade(
                      currentScore: double.parse(e.obtainedMarks),
                      totalScore: double.parse(e.assessment.maxMark)),
                  totalScore: double.parse(e.assessment.maxMark).toInt(),
                  onChanged: (value) {
                    if (value != null) {
                      EasyDebounce.debounce(
                        'on_save_score',
                        const Duration(milliseconds: 800),
                        () {
                          if (value.isNotEmpty) {
                            final mark = double.parse(value);
                            final maxMark = double.parse(e.assessment.maxMark);
                            if (mark > maxMark) {
                              CommonDialog.showMyDialog(
                                context: context,
                                body: 'Mark cannot exceed Max Mark',
                                title: 'Error',
                              );
                              if (e.obtainedMarks == "-1") {
                                controllers[i].text = '';
                              } else {
                                controllers[i].text = e.obtainedMarks;
                              }
                            } else {
                              context.read<StudentAssessmentBloc>().add(
                                    OnTypeAssessmentScore(
                                      value: value,
                                      index: widget.students.indexOf(e),
                                    ),
                                  );
                            }
                          }
                        },
                      );
                    }
                  },
                  hintText: 'Enter score..',
                  onFieldSubmitted: (value) {},
                ),
              ),
            ),
            // DataCell(
            //   CustomBtn(
            //     label: 'View',
            //     btnStyle: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.white,
            //       side: const BorderSide(color: ColorName.primary),
            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(15)),
            //       ),
            //     ),
            //     style: const TextStyle(color: ColorName.placeHolder),
            //     height: 30,
            //     onTap: () {
            //       // Navigator.of(context).pushNamed(
            //       //   SectionStudentPage.routeName,
            //       //   arguments:
            //       //       SectionStudentArgs(student: e, schedule: schedule),
            //       // );
            //     },
            //   ),
            // ),
          ],
        );
        widgets.add(dataRow);
      }
    } catch (e) {
      print(e);
    }
    // final widgets = students.map(
    //   (e) {
    //     return
    //   },
    // ).toList();

    if (widget.isPaginate) {
      widgets.add(
        DataRow(
          color: MaterialStateProperty.all(Colors.white),
          cells: const [
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return widgets;
  }

  Widget passedText(StudentAssessment value) {
    final pass = isPassed(
      totalScore: double.parse(value.assessment.maxMark),
      score: double.parse(value.obtainedMarks),
    );

    return Text(
      pass ? 'PASSED' : 'FAILED',
      style: TextStyle(
        color: pass ? null : Colors.red,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  bool isValidGrade(
      {required double currentScore, required double totalScore}) {
    return currentScore >= 0 && currentScore <= totalScore;
  }

  bool isPassed({
    required double totalScore,
    required double score,
  }) {
    if (score == 0) {
      return false;
    }

    return (((score / totalScore) * 50) + 50) >= 75;
  }
}
