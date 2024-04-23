import 'package:ease_studyante_teacher_app/src/section_student_table/data/models/student_list_response_model.dart';

abstract class StudentListRepository {
  Future<StudentListResponseModel> getStudentList({
    required String section,
    String? next,
    String? search,
    int limit = 70,
  });
}
