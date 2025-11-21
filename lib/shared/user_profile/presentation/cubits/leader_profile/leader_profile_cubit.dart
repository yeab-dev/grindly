import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';

part 'leader_profile_state.dart';

class LeaderProfileCubit extends Cubit<LeaderProfileState> {
  final UserRepository repository;
  LeaderProfileCubit({required this.repository})
    : super(LeaderProfileInitial(null));

  Future<void> getUser({required String grindlyID}) async {
    emit(LeaderProfileInProgress(state.user));
    try {
      final user = await repository.getUser(grindlyID);
      if (user != null) {
        emit(LeaderProfileSuccess(user.toEntity()));
      } else {
        emit(
          LeaderProfileFailure(
            state.user,
            errorMessage: 'couldn\'t get user information',
          ),
        );
      }
    } catch (e) {
      emit(LeaderProfileFailure(state.user, errorMessage: e.toString()));
    }
  }

  Future<void> follow({
    required String followingUserID,
    required String followedUserID,
  }) async {
    emit(LeaderProfileInProgress(state.user));
    try {
      await repository.follow(
        followingUserId: followingUserID,
        followedUserId: followedUserID,
      );
      emit(LeaderProfileSuccess(state.user));
    } catch (e) {
      emit(LeaderProfileFailure(state.user, errorMessage: "error"));
    }
  }
}
