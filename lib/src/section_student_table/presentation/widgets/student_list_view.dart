import 'package:data_table_2/data_table_2.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/section_student_page.dart';
import 'package:flutter/material.dart';

class StudentListView extends StatelessWidget {
  const StudentListView({
    super.key,
    required this.scrollController,
    required this.isPaginate,
    required this.students,
    required this.schedule,
  });

  final ScrollController scrollController;
  final bool isPaginate;
  final List<Student> students;
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      clipBehavior: Clip.hardEdge,
      scrollController: scrollController,
      isVerticalScrollBarVisible: true,
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
          fixedWidth: 50,
          numeric: true,
          onSort: (columnIndex, ascending) {},
          label: const Text(
            '',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn2(
          onSort: (columnIndex, ascending) {},
          label: const FittedBox(
            child: Text(
              'Lastname',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          label: FittedBox(
            child: Text(
              'Firsname',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          label: FittedBox(
            child: Text(
              'Year Level',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          fixedWidth: 75,
          label: FittedBox(
            child: Text(
              'Action',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: dataRows(context),
    );
  }

  List<DataRow> dataRows(BuildContext context) {
    return students
        .map(
          (e) => DataRow(
            color: MaterialStateProperty.all(Colors.white),
            cells: [
              DataCell(Text('${students.indexOf(e) + 1}')),
              DataCell(
                CircleAvatar(
                  backgroundColor: ColorName.primary,
                  backgroundImage: e.profilePhoto != null
                      ? Image.network(e.profilePhoto!).image
                      : null,
                  radius: 45,
                  child: e.profilePhoto != null
                      ? null
                      : const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                ),
              ),
              DataCell(Text(e.user.lastName)),
              DataCell(Text(e.user.firstName)),
              DataCell(Text(e.yearLevel)),
              DataCell(CustomBtn(
                label: 'View',
                height: 30,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    SectionStudentPage.routeName,
                    arguments:
                        SectionStudentArgs(student: e, schedule: schedule),
                  );
                },
              )),
            ],
          ),
        )
        .toList();
  }
}
