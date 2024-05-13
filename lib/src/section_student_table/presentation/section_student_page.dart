import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/main_scaffold.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/notification_modal.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/attendance/presentation/widgets/attendance_screen.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/parent.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/widgets/person_card.dart';
import 'package:ease_studyante_teacher_app/src/subject/presentation/widgets/subject_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';

import 'package:gap/gap.dart';

class SectionStudentArgs {
  final Student student;
  final Schedule schedule;

  SectionStudentArgs({
    required this.student,
    required this.schedule,
  });
}

class SectionStudentPage extends StatefulWidget {
  static const String routeName = '/section/student';
  final SectionStudentArgs args;

  const SectionStudentPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<SectionStudentPage> createState() => _SectionStudentPageState();
}

class _SectionStudentPageState extends State<SectionStudentPage> {
  late Student student;
  late Schedule schedule;
  late Parent? parent;

  @override
  void initState() {
    super.initState();

    student = widget.args.student;
    schedule = widget.args.schedule;
    parent = widget.args.student.parent;
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: 'Student Information',
          showBackBtn: true,
          actions: [const NotificationModal()],
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PersonCard(
                  age: student.age.toString(),
                  firstName: student.user.firstName,
                  lastName: student.user.lastName,
                  gender: student.gender == 'M' ? "Male" : "Female",
                  lrn: student.lrn,
                  profilePhoto: student.profilePhoto,
                  section: schedule.section.name,
                  yearLevel: student.yearLevel,
                  contactNumber: student.contactNumber,
                  extraButtons: [
                    CustomBtn(
                      width: 145,
                      height: 45,
                      label: 'View Attendance',
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AttendanceScreen.routeName,
                          arguments: AttendanceScreenArgs(
                            subject: schedule.subject,
                            student: student,
                          ),
                        );
                      },
                    ),
                    const Gap(10),
                    CustomBtn(
                      width: 145,
                      height: 45,
                      label: 'View Grades',
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          SubjectDetailScreen.routeName,
                          arguments: SubjectDetailScreenArgs(
                            subject: schedule.subject,
                            student: student,
                            section: schedule.section,
                            studentId: student.user.pk,
                            isTeacher: true,
                          ),
                        );
                      },
                    )
                  ],
                ),
                const Gap(10),
                if (parent != null) ...[
                  const Text(
                    'Parent Information',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorName.placeHolder,
                      fontSize: 23,
                    ),
                  ),
                  const Gap(10),
                  PersonCard(
                    age: student.age.toString(),
                    firstName: parent!.user.firstName,
                    lastName: parent!.user.lastName,
                    gender: parent!.gender == 'M' ? "Male" : "Female",
                    profilePhoto: parent!.profilePhoto,
                    contactNumber: parent!.contactNumber,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
