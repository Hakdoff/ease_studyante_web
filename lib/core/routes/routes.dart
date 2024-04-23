import 'package:ease_studyante_teacher_app/core/bloc/global_bloc.dart';
import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/src/assessment/assessment_page.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/presentation/student_assessment_table_page.dart';
import 'package:ease_studyante_teacher_app/src/attendance/presentation/widgets/attendance_screen.dart';
import 'package:ease_studyante_teacher_app/src/home/presentation/home.dart';
import 'package:ease_studyante_teacher_app/src/login/presentation/login.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/section_student_page.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/presentation/section_student_table_page.dart';
import 'package:ease_studyante_teacher_app/src/subject/presentation/widgets/grading_detail_screen.dart';
import 'package:ease_studyante_teacher_app/src/subject/presentation/widgets/subject_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/assessment_table/presentation/assessment_table_page.dart';

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  CustomPageRoute({builder, settings, fullscreenDialog})
      : super(
          builder: builder,
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        );
}

Widget _getAuthenticatedRoute({
  required Widget page,
  required BuildContext context,
}) {
  final isAuthenticated =
      context.read<GlobalBloc>().state.viewStatus == ViewStatus.successful;

  // Check if user is authenticated before allowing access to the page

  return isAuthenticated ? page : const LoginPage();
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  return CustomPageRoute(
    fullscreenDialog: true,
    settings: settings,
    builder: (context) {
      switch (settings.name) {
        case LoginPage.routeName:
          return _getAuthenticatedRoute(
              page: const HomePage(), context: context);
        case HomePage.routeName:
          return _getAuthenticatedRoute(
              page: const HomePage(), context: context);

        case SectionStudentTablePage.routeName:
          if (settings.arguments == null) {
            return returnHome(context);
          }

          final args = settings.arguments! as StudentListArgs;
          return _getAuthenticatedRoute(
              page: SectionStudentTablePage(args: args), context: context);

        case PlaceHolderPage.routeName:
          return _getAuthenticatedRoute(
              page: const PlaceHolderPage(), context: context);
        case SectionStudentPage.routeName:
          if (settings.arguments == null) {
            return returnHome(context);
          }
          final args = settings.arguments! as SectionStudentArgs;

          return _getAuthenticatedRoute(
              page: SectionStudentPage(args: args), context: context);

        case AssessmentPage.routeName:
          return _getAuthenticatedRoute(
              page: const AssessmentPage(), context: context);

        case AssessmentTablePage.routeName:
          if (settings.arguments == null) {
            return returnHome(context);
          }

          final args = settings.arguments! as AssessmentListArgs;
          return _getAuthenticatedRoute(
              page: AssessmentTablePage(args: args), context: context);

        case StudentAssessmentTablePage.routeName:
          if (settings.arguments == null) {
            return returnHome(context);
          }

          final args = settings.arguments! as StudentAssessmentListArgs;
          return _getAuthenticatedRoute(
              page: StudentAssessmentTablePage(args: args), context: context);

        case AttendanceScreen.routeName:
          if (settings.arguments == null) {
            return returnHome(context);
          }
          final args = settings.arguments! as AttendanceScreenArgs;

          return _getAuthenticatedRoute(
              page: AttendanceScreen(args: args), context: context);

        case GradingDetailScreen.routeName:
          if (settings.arguments == null) {
            return returnHome(context);
          }
          final args = settings.arguments! as GradingDetailScreenArgs;

          return _getAuthenticatedRoute(
              page: GradingDetailScreen(args: args), context: context);

        case SubjectDetailScreen.routeName:
          if (settings.arguments == null) {
            return returnHome(context);
          }
          final args = settings.arguments! as SubjectDetailScreenArgs;

          return _getAuthenticatedRoute(
              page: SubjectDetailScreen(args: args), context: context);
      }

      return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Text('Something went wrong'),
        ),
      );
    },
  );
}

Widget returnHome(BuildContext context) {
  return _getAuthenticatedRoute(page: const HomePage(), context: context);
}
