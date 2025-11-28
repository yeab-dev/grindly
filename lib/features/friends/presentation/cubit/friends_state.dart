part of 'friends_cubit.dart';

sealed class FriendsState extends Equatable {
  final String? profileID;
  final List<User>? followers;
  final List<User>? following;
  final User? user;
  const FriendsState({
    required this.profileID,
    this.followers,
    this.following,
    this.user,
  });
  @override
  List<Object?> get props => [profileID];
}

final class FriendsStateInitial extends FriendsState {
  const FriendsStateInitial() : super(profileID: null);
}

final class FriendsStateInProgress extends FriendsState {
  const FriendsStateInProgress({required super.profileID});
}

final class FriendsStateSuccess extends FriendsState {
  const FriendsStateSuccess({
    required super.profileID,
    super.followers,
    super.following,
    super.user,
  });
}

final class FriendsStateFailure extends FriendsState {
  final String errorMessage;
  const FriendsStateFailure({
    required super.profileID,
    required this.errorMessage,
    super.user,
  });
}
