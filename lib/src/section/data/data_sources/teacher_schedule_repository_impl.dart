import 'package:ease_studyante_teacher_app/core/config/app_constant.dart';
import 'package:ease_studyante_teacher_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_teacher_app/src/section/data/models/teacher_schedule_model.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/repositories/teacher_schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  @override
  Future<ScheduleModel> getSchedules({String? nextPage}) async {
    String url = nextPage ?? '${AppConstant.apiUrl}/teacher/schedules';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      final schedules = results.map((e) => Schedule.fromMap(e)).toList();
      return ScheduleModel(
          schedules: schedules,
          nextPage: value.data['next'],
          totalCount: value.data['count']);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
