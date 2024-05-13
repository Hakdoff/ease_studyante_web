import 'package:ease_studyante_teacher_app/core/bloc/global_bloc.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/gpa_tile_widget.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/data/models/teacher_assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/domain/repositories/teacher_assessment_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/section/data/models/subject_model.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/section.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';
import 'package:ease_studyante_teacher_app/src/subject/data/blocs/bloc/subject_detail_bloc.dart';
import 'package:ease_studyante_teacher_app/src/subject/domain/models/student_overall_grade_model.dart';
import 'package:ease_studyante_teacher_app/src/subject/presentation/widgets/grading_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectDetailScreenArgs {
  final SubjectModel subject;
  final Section section;
  final bool isTeacher;
  final String studentId;
  final Student student;

  SubjectDetailScreenArgs({
    required this.subject,
    required this.section,
    required this.isTeacher,
    required this.studentId,
    required this.student,
  });
}

class SubjectDetailScreen extends StatefulWidget {
  static const String routeName = '/view-grades';
  final SubjectDetailScreenArgs args;
  const SubjectDetailScreen({
    super.key,
    required this.args,
  });

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  late SubjectDetailBloc subjectDetailBloc;
  late GlobalBloc globalBloc;
  ValueNotifier<List<TeacherAssessmentModel>> gradingList = ValueNotifier([]);
  List<String> tempList = [];
  @override
  void initState() {
    super.initState();

    subjectDetailBloc = SubjectDetailBloc(
        assessmentRepository: TeacherAssessmentRepositoryImpl());
    if (!widget.args.isTeacher) {
      subjectDetailBloc.add(
        GetAssessmentEvent(subjectId: widget.args.subject.id),
      );
      subjectDetailBloc.add(
        GetStudentOverallGrade(
          subjectId: widget.args.subject.id,
        ),
      );
    } else {
      subjectDetailBloc.add(
        GetAssessmentTeacherEvent(studentId: widget.args.studentId),
      );
      subjectDetailBloc.add(
        GetStudentTeacherOverallGrade(
          subjectId: widget.args.subject.id,
          studentId: widget.args.studentId,
        ),
      );
    }

    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  double getListViewHeight(StudentOverallGradeModel gradeModel) {
    double height = 0;

    if (gradeModel.isViewGrade) {
      if (gradeModel.firstGrading != 'N/A') {
        height += 110;
      }
      if (gradeModel.secondGrading != 'N/A') {
        height += 110;
      }
      if (gradeModel.thirdGrading != 'N/A') {
        height += 110;
      }
      if (gradeModel.fourthGrading != 'N/A') {
        height += 110;
      }

      if (gradeModel.totalGpa != 'N/A') {
        height += 30;
      }
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args.subject.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorName.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<SubjectDetailBloc, SubjectDetailState>(
        bloc: subjectDetailBloc,
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.successful) {
            for (var element in state.assessment) {
              if (element.assessment.subject.code == widget.args.subject.code) {
                if (!tempList.contains(element.assessment.gradingPeriod)) {
                  tempList.add(element.assessment.gradingPeriod);
                  gradingList.value.add(element);
                }
              }
            }
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SpacedColumn(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: SpacedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subject Code: ${widget.args.subject.code}',
                          ),
                          Text(
                            'Department: ${widget.args.subject.department.name}',
                          ),
                          Text(
                            'Department code: ${widget.args.subject.department.code}',
                          ),
                          Text(
                            'Year Level: ${widget.args.subject.yearLevel}',
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: SpacedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${widget.args.student.user.firstName} ${widget.args.student.user.lastName}',
                          ),
                          Text(
                            'Learner Reference Number: ${widget.args.student.lrn}',
                          ),
                          Text(
                            'Section: ${widget.args.section.name}',
                          )
                        ],
                      ),
                    ),
                  ),
                  if (state.studentOverallGrade.isViewGrade &&
                      state.studentOverallGrade.totalGpa != 'N/A') ...[
                    GpaTileWidget(
                      title: 'GPA',
                      gpa: state.studentOverallGrade.totalGpa ?? '',
                    ),
                  ],
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed(
                  //       AttendanceScreen.routeName,
                  //       arguments: AttendanceScreenArgs(
                  //         subject: widget.args.subject,
                  //         student: widget.args.student,
                  //       ),
                  //     );
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: const Color(0xFF494E56),
                  //   ),
                  //   child: const Text(
                  //     'View Attendance',
                  //   ),
                  // ),
                  if (state.studentOverallGrade.isViewGrade) ...[
                    const Divider(
                      thickness: 3,
                    ),
                    ValueListenableBuilder(
                      valueListenable: gradingList,
                      builder: (context, value, child) {
                        return SizedBox(
                          height: getListViewHeight(state.studentOverallGrade),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: GradingItemWidget(
                                  assessment: value[index],
                                  subjectDetailBloc: subjectDetailBloc,
                                  subject: widget.args.subject,
                                  studentGrade: state.studentOverallGrade,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemCount: value.length,
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
