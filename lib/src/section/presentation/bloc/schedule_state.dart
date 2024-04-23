part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleError extends ScheduleState {
  final String errorMessage;

  const ScheduleError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class ScheduleLoaded extends ScheduleState {
  final ScheduleModel scheduleModel;
  final bool isPaginate;

  const ScheduleLoaded({
    required this.scheduleModel,
    this.isPaginate = false,
  });

  @override
  List<Object> get props => [
        ScheduleModel,
        isPaginate,
      ];

  ScheduleLoaded copyWith({
    ScheduleModel? scheduleModel,
    bool? isPaginate,
  }) {
    return ScheduleLoaded(
      scheduleModel: scheduleModel ?? this.scheduleModel,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }
}
