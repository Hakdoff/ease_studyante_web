import 'package:collection/collection.dart';
import 'package:ease_studyante_teacher_app/core/bloc/global_bloc.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/main_scaffold.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/notification_modal.dart';
import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/core/extensions/time_formatter.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/data/data_sources/assessment_student_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/presentation/bloc/assessment/student_assessment_bloc.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/presentation/widgets/student_assessment_list_view.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/domain/entities/assessment.dart';
import 'package:ease_studyante_teacher_app/src/profile/domain/entities/grading_periods.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/data/data_sources/student_list_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class StudentAssessmentListArgs {
  final Assessment assessment;
  final Schedule schedule;
  final String appbarTitle;

  StudentAssessmentListArgs({
    required this.assessment,
    required this.appbarTitle,
    required this.schedule,
  });
}

class StudentAssessmentTablePage extends StatefulWidget {
  static const String routeName = 'teacher/assessment/student';
  final StudentAssessmentListArgs args;

  const StudentAssessmentTablePage({super.key, required this.args});

  @override
  State<StudentAssessmentTablePage> createState() =>
      _StudentAssessmentTablePageState();
}

class _StudentAssessmentTablePageState
    extends State<StudentAssessmentTablePage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late StudentAssessmentBloc studentAssessmentBloc;
  GradingPeriods? period;
  ValueNotifier<bool> isSearch = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    studentAssessmentBloc = StudentAssessmentBloc(
      studentAssessmentRepository: StudentAssessmentRepositoryImpl(),
      studentListRepository: StudentListRepositoryImpl(),
    );
    handleGetPeriod();
    initBloc();
    handleEventScrollListener();
    searchController.addListener(() {
      isSearch.value = searchController.value.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => studentAssessmentBloc,
      child: MainScaffold(
        child: Scaffold(
          appBar: buildAppBar(
            context: context,
            title: widget.args.appbarTitle,
            showBackBtn: true,
            actions: [const NotificationModal()],
          ),
          body: BlocBuilder<StudentAssessmentBloc, StudentAssessmentState>(
            builder: (context, state) {
              if (state.viewStatus == ViewStatus.failed) {
                return Center(
                  child: CustomText(
                      text: state.errorMessage ?? 'Something went wrong'),
                );
              }

              if (state.viewStatus == ViewStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Row(
                        children: [
                          const Gap(10),
                          Expanded(
                            child: SearchField(
                              suffixIcon: ValueListenableBuilder(
                                valueListenable: isSearch,
                                builder: (BuildContext context, dynamic value,
                                    Widget? child) {
                                  return value
                                      ? InkWell(
                                          onTap: () {
                                            initBloc();
                                            isSearch.value = false;
                                            searchController.text = '';
                                          },
                                          child: const Icon(
                                            Icons.clear,
                                            size: 27,
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                              controller: searchController,
                              hintText: 'Search student...',
                              onFieldSubmitted: (value) {
                                if (value.trim().isEmpty) {
                                  return initBloc();
                                }

                                return studentAssessmentBloc.add(
                                  OnSearchStudent(
                                    sectionId: widget.args.schedule.section.id,
                                    subjectId: widget.args.schedule.subject.id,
                                    studentName: value,
                                    assessmentId: widget.args.assessment.id,
                                  ),
                                );
                              },
                              onTap: () {},
                            ),
                          ),
                          const Gap(10),
                          CustomBtn(
                            width: 100,
                            label: 'Search',
                            onTap: () {
                              if (searchController.value.text.trim().isEmpty) {
                                return initBloc();
                              }

                              return studentAssessmentBloc.add(
                                OnSearchStudent(
                                  sectionId: widget.args.schedule.section.id,
                                  subjectId: widget.args.schedule.subject.id,
                                  studentName: searchController.value.text,
                                  assessmentId: widget.args.assessment.id,
                                ),
                              );
                            },
                          ),
                          // const Gap(10),
                          // CustomBtn(
                          //   width: 100,
                          //   label: 'Filters',
                          //   onTap: () {},
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //   ),
                          //   icon: const Icon(Icons.filter_list_alt),
                          // ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: ColorName.placeHolder,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (!isEncodeEnable())
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Encoding is already closed.",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (isEncodeEnable())
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Encoding is open",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Text(
                          'Assessment Name: ${widget.args.assessment.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const Gap(10),
                        Text('Max Score: ${widget.args.assessment.maxMark}'),
                        const Gap(10),
                        Text(
                          'Date Created: ${widget.args.assessment.createdAt.parseStrToDate()}',
                          style: const TextStyle(
                            color: ColorName.placeHolder,
                          ),
                        )
                      ],
                    ),
                    const Gap(20),
                    Expanded(
                      child: StudentAssessmentListView(
                        scrollController: scrollController,
                        isPaginate: state.viewStatus == ViewStatus.isPaginated,
                        students: state.studentAssessmentModel.assessments,
                        isEncodeEnable: !isEncodeEnable(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: BlocSelector<StudentAssessmentBloc,
              StudentAssessmentState, StudentAssessmentState>(
            selector: (state) {
              return state;
            },
            builder: (context, state) {
              if (!state.isOnSaveScore) {
                return const SizedBox();
              }
              return Container(
                decoration: BoxDecoration(
                    color: ColorName.primary,
                    borderRadius: BorderRadius.circular(7)),
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Saving please wait',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void initBloc() {
    studentAssessmentBloc.add(
      OnGetStudentAssessmentEvent(
        assessmentId: widget.args.assessment.id,
        sectionId: widget.args.schedule.section.id,
        subjectId: widget.args.schedule.subject.id,
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        studentAssessmentBloc.add(
          OnPaginateStudentAssessmentEvent(
            sectionId: widget.args.schedule.section.id,
            subjectId: widget.args.schedule.subject.id,
            assessmentId: widget.args.assessment.id,
          ),
        );
      }
    });
  }

  void handleGetPeriod() {
    List<GradingPeriods> gradingPeriods =
        context.read<GlobalBloc>().state.profile.gradingPeriods;

    setState(() {
      period = gradingPeriods.firstWhereOrNull((element) =>
          element.period.toUpperCase() ==
          widget.args.assessment.gradingPeriod.toUpperCase());
    });
  }

  bool isEncodeEnable() {
    final currentDateTime = DateTime.now();

    if (period == null) {
      return false;
    }

    return currentDateTime.isBefore(period!.gradingDeadline) ||
        period!.isOverrideEncoding;
  }
}
