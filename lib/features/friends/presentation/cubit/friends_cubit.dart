import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/friends/domain/repositories/friends_repository.dart';
import 'package:grindly/shared/user_profile/data/models/user_model.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  final FriendsRepository friendsRepository;
  final UserRepository userRepository;
  FriendsCubit({required this.friendsRepository, required this.userRepository})
    : super(FriendsStateInitial());

  Future<void> getUserNetwork({required String userId}) async {
    emit(FriendsStateInProgress(profileID: userId));
    try {
      final followerIDs = await friendsRepository.getFollowerIDs(uid: userId);
      final followingIDs = await friendsRepository.getFollowingIDs(uid: userId);

      final followerFutures = followerIDs.map((followerID) async {
        final UserModel? userModel = await userRepository.getUser(followerID);
        if (userModel != null) {
          return userModel.toEntity();
        }
        return null;
      }).toList();

      final followingFutures = followingIDs.map((followingID) async {
        final UserModel? userModel = await userRepository.getUser(followingID);
        if (userModel != null) {
          return userModel.toEntity();
        }
        return null;
      }).toList();

      final List<User> followers = (await Future.wait(
        followerFutures,
      )).whereType<User>().toList();
      final List<User> following = (await Future.wait(
        followingFutures,
      )).whereType<User>().toList();

      emit(
        FriendsStateSuccess(
          profileID: userId,
          followers: followers,
          following: following,
        ),
      );
    } catch (e) {
      emit(FriendsStateFailure(profileID: userId, errorMessage: e.toString()));
    }
  }

  Future<void> getUser({required String userID}) async {
    emit(FriendsStateInProgress(profileID: userID));
    try {
      final UserModel? userModel = await userRepository.getUser(userID);
      if (userModel != null) {
        emit(
          FriendsStateSuccess(profileID: userID, user: userModel.toEntity()),
        );
      } else {
        emit(
          FriendsStateFailure(
            profileID: userID,
            errorMessage: 'Couldn\'t get profile',
          ),
        );
      }
    } catch (e) {
      emit(FriendsStateFailure(profileID: userID, errorMessage: e.toString()));
    }
  }
}
