part of 'other_users_profile_cubit.dart';

class OtherUsersProfileState {
  // capturing the user data to allow partial user data loading
  final User? user;
  const OtherUsersProfileState(this.user);
}

final class OtherUsersProfileInitial extends OtherUsersProfileState {
  OtherUsersProfileInitial(super.user);
}

final class OtherUsersProfileInProgress extends OtherUsersProfileState {
  OtherUsersProfileInProgress(super.user);
}

final class OtherUsersProfileSuccess extends OtherUsersProfileState {
  const OtherUsersProfileSuccess(super.user);
}

final class OtherUsersProfileFailure extends OtherUsersProfileState {
  final String errorMessage;
  const OtherUsersProfileFailure(super.user, {required this.errorMessage});
}
