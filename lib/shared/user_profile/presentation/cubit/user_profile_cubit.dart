import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart'
    as grindly_user;
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserRepository repository;
  UserProfileCubit({required this.repository}) : super(UserProfileInitial());

  Future<void> getUser() async {
    emit(UserProfileInProgress());
    try {
      final user = getIt<FirebaseAuth>().currentUser;
      if (user == null) {
        emit(UserProfileFailure(errorMessage: 'No user signed in'));
        throw Exception('No user signed in');
      }
      await user.reload();
      final uid = user.uid;
      final grindlyUser = await repository.getUser(uid);
      emit(UserProfileSuccess(user: grindlyUser!));
    } catch (e) {
      emit(UserProfileFailure(errorMessage: 'Could\'t get profile info'));
    }
  }
}
