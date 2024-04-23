import 'package:ease_studyante_teacher_app/core/config/app_constant.dart';
import 'package:ease_studyante_teacher_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/data/models/student_list_response_model.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/domain/repositories/student_list_reopsitory.dart';

class StudentListRepositoryImpl extends StudentListRepository {
  @override
  Future<StudentListResponseModel> getStudentList({
    required String section,
    String? next,
    String? search,
    int limit = 70,
  }) async {
    final String q = search != null ? "&search=$search" : "";
    final String url =
        '${AppConstant.apiUrl}/teacher/registered/students?limit=$limit&section=$section$q';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      return StudentListResponseModel.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
