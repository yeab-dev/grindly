part of 'user_profile_cubit.dart';

sealed class UserProfileState {
  const UserProfileState();
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileInProgress extends UserProfileState {}

final class UserProfileSuccess extends UserProfileState {
  final grindly_user.User user;
  const UserProfileSuccess({required this.user});
}

final class UserProfileFailure extends UserProfileState {
  final String errorMessage;
  const UserProfileFailure({required this.errorMessage});
}
