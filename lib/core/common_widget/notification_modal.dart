import 'package:ease_studyante_teacher_app/core/bloc/global_bloc.dart';
import 'package:ease_studyante_teacher_app/core/extensions/time_formatter.dart';
import 'package:ease_studyante_teacher_app/src/profile/domain/entities/grading_periods.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationModal extends StatelessWidget {
  const NotificationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _dialogBuilder(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: -10, end: 0),
          ignorePointer: false,
          onTap: () {},
          badgeContent: const Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          badgeAnimation: const badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: Colors.blue,
            padding: const EdgeInsets.all(5),
            borderRadius: BorderRadius.circular(4),
            elevation: 0,
          ),
          child: const Icon(Icons.notifications, color: Colors.white, size: 35),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: Text(getDealineDescription(context)),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String getDealineDescription(BuildContext context) {
    final currentDateTime = DateTime.now();
    List<GradingPeriods> gradingPeriods =
        context.read<GlobalBloc>().state.profile.gradingPeriods;
    gradingPeriods.sort(
      (a, b) => a.gradingDeadline.compareTo(b.gradingDeadline),
    );

    gradingPeriods = gradingPeriods
        .where((e) => e.gradingDeadline.isAfter(currentDateTime))
        .toList();

    if (gradingPeriods.isNotEmpty) {
      final gradingPeriod = gradingPeriods.first;
      final dateDiff =
          gradingPeriod.gradingDeadline.difference(currentDateTime);
      if (dateDiff.inDays <= 30 && dateDiff.inDays > 0) {
        return "Deadline of Encoding will be until ${gradingPeriod.gradingDeadline.toString().parseStrToDate()}. You have approximately ${dateDiff.inDays}day(s) to encode the grades.";
      }
    }

    return "No Notification so far";
  }
}
