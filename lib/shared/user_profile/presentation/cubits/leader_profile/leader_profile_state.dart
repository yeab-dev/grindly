part of 'leader_profile_cubit.dart';

class LeaderProfileState {
  // capturing the user data to allow partial user data loading
  final User? user;
  const LeaderProfileState(this.user);
}

final class LeaderProfileInitial extends LeaderProfileState {
  LeaderProfileInitial(super.user);
}

final class LeaderProfileInProgress extends LeaderProfileState {
  LeaderProfileInProgress(super.user);
}

final class LeaderProfileSuccess extends LeaderProfileState {
  const LeaderProfileSuccess(super.user);
}

final class LeaderProfileFailure extends LeaderProfileState {
  final String errorMessage;
  const LeaderProfileFailure(super.user, {required this.errorMessage});
}
