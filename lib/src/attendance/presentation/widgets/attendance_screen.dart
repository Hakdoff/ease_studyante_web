import 'package:ease_studyante_teacher_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/src/attendance/data/repository/teacher_attendance_repository_impl.dart';
import 'package:ease_studyante_teacher_app/src/attendance/presentation/blocs/bloc/teacher_attendance_bloc.dart';
import 'package:ease_studyante_teacher_app/src/attendance/presentation/widgets/attendance_item.dart';
import 'package:ease_studyante_teacher_app/src/section/data/models/subject_model.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreenArgs {
  final SubjectModel subject;
  final Student student;

  AttendanceScreenArgs({
    required this.subject,
    required this.student,
  });
}

class AttendanceScreen extends StatefulWidget {
  static const String routeName = '/attendance';

  final AttendanceScreenArgs args;
  const AttendanceScreen({
    super.key,
    required this.args,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late TeacherAttendanceBloc teacherAttendanceBloc;

  @override
  void initState() {
    super.initState();
    teacherAttendanceBloc = TeacherAttendanceBloc(
      attendanceRepository: TeacherAttendanceRepositoryImpl(),
    );
    teacherAttendanceBloc.add(
      GetTeacherStudentAttendanceEvent(
        subject: widget.args.subject,
        student: widget.args.student,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Attendance',
        showBackBtn: true,
      ),
      body: BlocBuilder<TeacherAttendanceBloc, TeacherAttendanceState>(
        bloc: teacherAttendanceBloc,
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (context, index) => AttendanceItemWidget(
                studentAttendance: state.studentAttendance[index],
              ),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(thickness: 3),
              ),
              itemCount: state.studentAttendance.length,
            ),
          );
        },
      ),
    );
  }
}
