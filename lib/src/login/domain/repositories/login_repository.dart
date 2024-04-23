import 'package:ease_studyante_teacher_app/src/profile/domain/entities/profile.dart';

import '../../data/models/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login({
    required String email,
    required String password,
    bool isStudent = false,
    bool isTeacher = false,
    bool isParent = false,
  });
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  Future<void> saveProfile(Profile profile);
}
