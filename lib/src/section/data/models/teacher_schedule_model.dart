import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:equatable/equatable.dart';

class ScheduleModel extends Equatable {
  final String? nextPage;
  final int totalCount;
  final List<Schedule> schedules;

  const ScheduleModel({
    this.nextPage,
    required this.totalCount,
    required this.schedules,
  });

  @override
  List<Object?> get props => [nextPage, totalCount, schedules];
}
