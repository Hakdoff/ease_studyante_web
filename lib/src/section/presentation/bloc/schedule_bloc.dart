import 'package:ease_studyante_teacher_app/src/section/data/models/teacher_schedule_model.dart';
import 'package:ease_studyante_teacher_app/src/section/domain/repositories/teacher_schedule_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository repository;

  ScheduleBloc(this.repository) : super(ScheduleInitial()) {
    on<OnGetScheduleEvent>(onGetScheduleEvent);
  }

  Future<void> onGetScheduleEvent(
      OnGetScheduleEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());

    try {
      final response = await repository.getSchedules();
      emit(ScheduleLoaded(scheduleModel: response));
    } catch (e) {
      emit(ScheduleError(errorMessage: e.toString()));
    }
  }
}
