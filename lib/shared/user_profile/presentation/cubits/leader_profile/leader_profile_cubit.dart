import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';

part 'leader_profile_state.dart';

class LeaderProfileCubit extends Cubit<LeaderProfileState> {
  final UserRepository repository;
  LeaderProfileCubit({required this.repository})
    : super(LeaderProfileInitial());

  Future<void> getUser({required String grindlyID}) async {
    emit(LeaderProfileInProgress());
    try {
      final user = await repository.getUser(grindlyID);
      if (user != null) {
        emit(LeaderProfileSuccess(user: user.toEntity()));
      } else {
        emit(
          LeaderProfileFailure(errorMessage: 'couldn\'t get user information'),
        );
      }
    } catch (e) {
      emit(LeaderProfileFailure(errorMessage: e.toString()));
    }
  }
}
