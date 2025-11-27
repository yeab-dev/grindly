import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';

part 'other_users_profile_state.dart';

class OtherUsersProfileCubit extends Cubit<OtherUsersProfileState> {
  final UserRepository repository;
  Timer? _debounce;
  OtherUsersProfileCubit({required this.repository})
    : super(OtherUsersProfileInitial(null));

  Future<void> getUser({required String grindlyID}) async {
    if (state.user == null) {
      emit(OtherUsersProfileInProgress(state.user));
    }
    try {
      final user = await repository.getUser(grindlyID);
      if (user != null) {
        emit(OtherUsersProfileSuccess(user.toEntity()));
      } else {
        emit(
          OtherUsersProfileFailure(
            state.user,
            errorMessage: 'couldn\'t get user information',
          ),
        );
      }
    } catch (e) {
      emit(OtherUsersProfileFailure(state.user, errorMessage: e.toString()));
    }
  }

  Future<void> follow({
    required String followingUserID,
    required String followedUserID,
  }) async {
    try {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () async {
        await repository.follow(
          followingUserID: followingUserID,
          userBeingFollowedID: followedUserID,
        );
        await getUser(grindlyID: followedUserID);
      });
    } catch (e) {
      emit(OtherUsersProfileFailure(state.user, errorMessage: "error"));
    }
  }

  Future<void> unfollow({
    required String unfollowingUserID,
    required String userBeingUnfollowed,
  }) async {
    try {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () async {
        await repository.unfollow(
          unfollowingUserID: unfollowingUserID,
          userBeingUnfollowedID: userBeingUnfollowed,
        );
        await getUser(grindlyID: userBeingUnfollowed);
      });
    } catch (e) {
      emit(OtherUsersProfileFailure(state.user, errorMessage: "error"));
    }
  }
}
