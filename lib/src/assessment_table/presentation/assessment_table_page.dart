import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/main_scaffold.dart';
import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/presentation/student_assessment_table_page.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/data/data_sources/assessment_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/bloc/assessment/assessment_bloc.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/bloc/assessment_filter/assessment_filter_cubit.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/widgets/assessment_filter.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/widgets/assessment_list_view.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/widgets/drawer_assessment_filter.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AssessmentListArgs {
  final Schedule schedule;
  final String appbarTitle;

  AssessmentListArgs({
    required this.schedule,
    required this.appbarTitle,
  });
}

class AssessmentTablePage extends StatefulWidget {
  static const String routeName = 'teacher/assessment/list';
  final AssessmentListArgs args;

  const AssessmentTablePage({super.key, required this.args});

  @override
  State<AssessmentTablePage> createState() => _AssessmentTablePageState();
}

class _AssessmentTablePageState extends State<AssessmentTablePage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late AssessmentBloc assessmentBloc;
  late String subjectId;

  @override
  void initState() {
    subjectId = widget.args.schedule.subject.id;
    super.initState();
    assessmentBloc = AssessmentBloc(AssessmentRepositoryImpl());
    initBloc();
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => assessmentBloc,
      child: MainScaffold(
        child: Scaffold(
            endDrawer: const DrawerAssessmentFilter(),
            appBar: buildAppBar(
              context: context,
              title: widget.args.appbarTitle,
              showBackBtn: true,
            ),
            body: BlocProvider(
              create: (context) => AssessmentFilterCubit(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Gap(10),
                          Expanded(
                            child: SearchField(
                              controller: searchController,
                              hintText: 'Search activity...',
                              onFieldSubmitted: (value) {
                                if (value.trim().isEmpty) {
                                  return initBloc();
                                }
                                final assessmentFilerState =
                                    context.read<AssessmentFilterCubit>().state;

                                return assessmentBloc.add(
                                  OnSearchActivityName(
                                    activityName: searchController.value.text,
                                    subjectId: widget.args.schedule.subject.id,
                                    assessmentType: assessmentFilerState
                                        .selectedAssessmentType,
                                    gradingPeriod: assessmentFilerState
                                        .selectedGradingPeriod,
                                    isAsceding:
                                        assessmentBloc.state.isAscending,
                                    taskType:
                                        assessmentFilerState.selectedTaskType,
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

                              final assessmentFilerState =
                                  context.read<AssessmentFilterCubit>().state;

                              return assessmentBloc.add(
                                OnSearchActivityName(
                                  activityName: searchController.value.text,
                                  subjectId: widget.args.schedule.subject.id,
                                  assessmentType: assessmentFilerState
                                      .selectedAssessmentType,
                                  gradingPeriod: assessmentFilerState
                                      .selectedGradingPeriod,
                                  isAsceding: assessmentBloc.state.isAscending,
                                  taskType:
                                      assessmentFilerState.selectedTaskType,
                                ),
                              );
                            },
                          ),
                          const Gap(10),
                          AssessmentFilter(
                            search: searchController.value.text,
                            subjectId: subjectId,
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    BlocBuilder<AssessmentBloc, AssessmentState>(
                      builder: (context, state) {
                        if (state.viewStatus == ViewStatus.failed) {
                          return Center(
                            child: CustomText(
                                text: state.errorMessage ??
                                    'Something went wrong'),
                          );
                        }

                        if (state.viewStatus == ViewStatus.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final assessmentFilerState =
                            context.read<AssessmentFilterCubit>().state;

                        return Expanded(
                          child: AssessmentListView(
                            onTapSort: () {
                              assessmentBloc.add(OnSortByName(
                                activityName: searchController.value.text,
                                subjectId: subjectId,
                                assessmentType:
                                    assessmentFilerState.selectedAssessmentType,
                                gradingPeriod:
                                    assessmentFilerState.selectedGradingPeriod,
                                isAsceding: state.isAscending != null
                                    ? !state.isAscending!
                                    : true,
                                taskType: assessmentFilerState.selectedTaskType,
                              ));
                            },
                            isAscending: state.isAscending,
                            scrollController: scrollController,
                            isPaginate:
                                state.viewStatus == ViewStatus.isPaginated,
                            assessments: state.assessmentModel.assessments,
                            onTap: (assessment) {
                              Navigator.of(context).pushNamed(
                                StudentAssessmentTablePage.routeName,
                                arguments: StudentAssessmentListArgs(
                                  schedule: widget.args.schedule,
                                  assessment: assessment,
                                  appbarTitle: assessment.name,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void initBloc() {
    assessmentBloc.add(OnGetAssessmentEvent(subjectId));
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        assessmentBloc.add(
          OnPaginateAssessmentEvent(
            activityName: searchController.value.text,
            subjectId: widget.args.schedule.id,
          ),
        );
      }
    });
  }
}
