part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final ViewStatus viewStatus;
  final Profile profile;
  final Profile studentProfile;

  const GlobalState({
    required this.viewStatus,
    required this.profile,
    required this.studentProfile,
  });

  GlobalState copyWith({
    ViewStatus? viewStatus,
    Profile? profile,
    Profile? studentProfile,
  }) {
    return GlobalState(
      viewStatus: viewStatus ?? this.viewStatus,
      profile: profile ?? this.profile,
      studentProfile: studentProfile ?? this.studentProfile,
    );
  }

  @override
  List<Object> get props => [
        viewStatus,
        profile,
      ];
}

final class GlobalInitial extends GlobalState {
  const GlobalInitial({
    required super.viewStatus,
    required super.profile,
    required super.studentProfile,
  });
}
