part of 'global_bloc.dart';

sealed class GlobalEvent extends Equatable {}

class StoreProfileEvent extends GlobalEvent {
  final Profile profile;
  StoreProfileEvent({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class SetProfileEvent extends GlobalEvent {
  @override
  List<Object?> get props => [];
}

class SetStudentProfileEvent extends GlobalEvent {
  @override
  List<Object?> get props => [];
}

class OnLogoutEvent extends GlobalEvent {
  @override
  List<Object?> get props => [];
}

class StoreStudentProfileEvent extends GlobalEvent {
  final Profile profile;
  StoreStudentProfileEvent({required this.profile});
  @override
  List<Object?> get props => [profile];
}
