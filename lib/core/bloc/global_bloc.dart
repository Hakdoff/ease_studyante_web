import 'dart:async';

import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/core/local_storage/local_storage.dart';
import 'package:ease_studyante_teacher_app/src/profile/domain/entities/profile.dart';
import 'package:ease_studyante_teacher_app/src/profile/domain/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final ProfileRepository _repository;

  GlobalBloc(this._repository)
      : super(
          GlobalInitial(
            profile: Profile.empty(),
            studentProfile: Profile.empty(),
            viewStatus: ViewStatus.none,
          ),
        ) {
    on<StoreProfileEvent>(_onStoreProfileEvent);
    on<SetProfileEvent>(_onSetProfileEvent);
    on<OnLogoutEvent>(_onLogoutEvent);
    on<StoreStudentProfileEvent>(_onStoreStudentProfileEvent);
    on<SetStudentProfileEvent>(_onSetStudentProfileEvent);
  }

  FutureOr<void> _onStoreStudentProfileEvent(
    StoreStudentProfileEvent event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        studentProfile: event.profile,
      ),
    );
  }

  FutureOr<void> _onLogoutEvent(
    OnLogoutEvent event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.none,
      ),
    );
  }

  FutureOr<void> _onStoreProfileEvent(
    StoreProfileEvent event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        profile: event.profile,
        viewStatus: ViewStatus.successful,
      ),
    );
  }

  Future<void> _onSetProfileEvent(
      SetProfileEvent event, Emitter<GlobalState> emit) async {
    final user = await LocalStorage.readLocalStorage('_user');
    if (user != null) {
      final response = await _repository.getUserProfile();
      emit(
        state.copyWith(
          profile: response,
          viewStatus: ViewStatus.successful,
        ),
      );
      // await registerFcmToken();
      return;
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
    }
    return emit(
      GlobalInitial(
        profile: Profile.empty(),
        viewStatus: ViewStatus.none,
        studentProfile: Profile.empty(),
      ),
    );
  }

  Future<void> _onSetStudentProfileEvent(
    SetStudentProfileEvent event,
    Emitter<GlobalState> emit,
  ) async {}
}
