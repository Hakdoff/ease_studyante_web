import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/main_scaffold.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/data/data_sources/student_list_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/bloc/student_list_bloc.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/widgets/search_field.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/widgets/student_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class StudentListArgs {
  final Schedule schedule;
  final String appbarTitle;

  StudentListArgs({
    required this.schedule,
    required this.appbarTitle,
  });
}

class SectionStudentTablePage extends StatefulWidget {
  static const String routeName = 'teacher/student/list';
  final StudentListArgs args;

  const SectionStudentTablePage({super.key, required this.args});

  @override
  State<SectionStudentTablePage> createState() =>
      _SectionStudentTablePageState();
}

class _SectionStudentTablePageState extends State<SectionStudentTablePage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late StudentListBloc studentListBloc;
  ValueNotifier<bool> isDisabled = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    studentListBloc = StudentListBloc(StudentListRepositoryImpl());
    initBloc();
    searchController.addListener(() {
      isDisabled.value = searchController.value.text.trim().isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => studentListBloc,
      child: MainScaffold(
        child: Scaffold(
          appBar: buildAppBar(
            context: context,
            title: widget.args.appbarTitle,
            showBackBtn: true,
          ),
          body: BlocBuilder<StudentListBloc, StudentListState>(
            builder: (context, state) {
              if (state is StudentListError) {
                return Center(
                  child: CustomText(text: state.errorMessage),
                );
              }
              if (state is StudentListLoaded) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Row(
                          children: [
                            const Gap(10),
                            Expanded(
                              child: SearchField(
                                controller: searchController,
                                hintText: 'Search student...',
                                onFieldSubmitted: (value) {},
                                onTap: () {},
                              ),
                            ),
                            const Gap(10),
                            ValueListenableBuilder(
                              valueListenable: isDisabled,
                              builder: (context, value, child) {
                                return CustomBtn(
                                  width: 100,
                                  label: 'Search',
                                  onTap: !value ? () {} : null,
                                );
                              },
                            ),
                            const Gap(10),
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
                      const Gap(20),
                      Expanded(
                        child: StudentListView(
                          scrollController: scrollController,
                          isPaginate: state.isPaginate,
                          students: state.studentList.students,
                          schedule: widget.args.schedule,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  void initBloc() {
    studentListBloc
        .add(OnGetTeacherStudentList(section: widget.args.schedule.section.id));
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        BlocProvider.of<StudentListBloc>(context).add(
            OnPaginateTeacherStudentList(
                section: widget.args.schedule.section.id));
      }
    });
  }
}
