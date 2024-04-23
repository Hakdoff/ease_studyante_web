import 'package:ease_studyante_teacher_app/src/login/domain/repositories/login_repository.dart';
import 'package:ease_studyante_teacher_app/src/profile/domain/entities/profile.dart';
import 'package:ease_studyante_teacher_app/src/profile/domain/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  final ProfileRepository profileRepository;

  LoginBloc(this.repository, this.profileRepository) : super(LoginInitial()) {
    on<OnSubmitLoginEvent>(onSubmitLoginEvent);
  }

  Future<void> onSubmitLoginEvent(
    OnSubmitLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());

      final response = await repository.login(
        email: event.emailAddress,
        password: event.password,
        isParent: event.isParent,
        isStudent: event.isStudent,
        isTeacher: event.isTeacher,
      );
      await repository.saveTokens(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
      );

      final profile = await profileRepository.getUserProfile();

      await repository.saveProfile(profile);

      emit(
        LoginSuccess(
          profile: profile,
        ),
      );
    } catch (e) {
      final dynamic error = e;
      emit(LoginError(error['data']['error_description']));
    }
  }
}
