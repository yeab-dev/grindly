part of 'leader_profile_cubit.dart';

class LeaderProfileState {
  const LeaderProfileState();
}

final class LeaderProfileInitial extends LeaderProfileState {}

final class LeaderProfileInProgress extends LeaderProfileState {}

final class LeaderProfileSuccess extends LeaderProfileState {
  final User user;
  const LeaderProfileSuccess({required this.user});
}

final class LeaderProfileFailure extends LeaderProfileState {
  final String errorMessage;
  const LeaderProfileFailure({required this.errorMessage});
}
