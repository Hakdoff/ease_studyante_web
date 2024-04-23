import 'package:ease_studyante_teacher_app/src/section/data/models/teacher_schedule_model.dart';

abstract class ScheduleRepository {
  Future<ScheduleModel> getSchedules({String? nextPage});
}
