import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/src/section/data/data_sources/teacher_schedule_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_teacher_app/src/section/presentation/bloc/schedule_bloc.dart';
import 'package:ease_studyante_teacher_app/src/section/presentation/widgets/section_card.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/section_student_table_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionPage extends StatefulWidget {
  static const String routeName = '/section';
  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  final ScrollController scrollController = ScrollController();
  late ScheduleBloc scheduleBloc;

  @override
  void initState() {
    super.initState();
    scheduleBloc = ScheduleBloc(ScheduleRepositoryImpl());
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => scheduleBloc..add(OnGetScheduleEvent()),
      child: Scaffold(
        appBar: buildAppBar(context: context, title: 'Section'),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleError) {
                  return const Center(
                    child: Text('Unable to load schedules'),
                  );
                }

                if (state is ScheduleLoaded) {
                  return Wrap(
                    spacing: 20.0,
                    runSpacing: 10.0,
                    children: [
                      ...sectionCards(state.scheduleModel.schedules),
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        BlocProvider.of<ScheduleBloc>(context).add(OnPaginateScheduleEvent());
      }
    });
  }

  List<Widget> sectionCards(List<Schedule> data) {
    return data
        .map((e) => SectionCard(
              schedule: e,
              onTap: () {
                Navigator.of(context).pushNamed(
                  SectionStudentTablePage.routeName,
                  arguments: StudentListArgs(
                      schedule: e,
                      appbarTitle:
                          '${e.section.yearLevel} - ${e.section.name}'),
                );
              },
            ))
        .toList();
  }
}
