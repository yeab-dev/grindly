import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/repositories/wakatime_profile_repository.dart';
import 'package:grindly/shared/user_profile/data/models/social_media_account.model.dart';
import 'package:grindly/shared/user_profile/data/models/user_model.dart';
import 'package:grindly/shared/user_profile/domain/entities/social_media_account.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart'
    as grindly_user;
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserRepository repository;
  final WakatimeProfileRepository wakatimeRepository;
  UserProfileCubit({required this.repository, required this.wakatimeRepository})
    : super(UserProfileInitial());

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
      final wakatimeAccount = await wakatimeRepository.getUserData();
      emit(
        UserProfileSuccess(
          user: grindly_user.User(
            uid: uid,
            email: grindlyUser!.email,
            displayName: grindlyUser.displayName,
            createdAt: grindlyUser.createdAt,
            wakatimeAccount: wakatimeAccount,
          ),
        ),
      );
    } catch (e) {
      emit(UserProfileFailure(errorMessage: 'Could\'t get profile info'));
    }
  }

  Future<void> updateUser({
    required String displayName,
    required String? bio,
    required String? xLink,
    required String? telegramLink,
  }) async {
    emit(UserProfileInProgress());
    try {
      final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();
      final uid = firebaseAuth.currentUser!.uid;
      UserModel? userModel = await repository.getUser(uid);
      final updatedUserModel = userModel?.copyWith(
        displayName: displayName,
        bio: bio,
        socialMediaAccounts: <SocialMediaAccountModel>[
          SocialMediaAccountModel(platformName: 'X', url: xLink ?? ""),
          SocialMediaAccountModel(
            platformName: 'Telegram',
            url: telegramLink ?? "",
          ),
        ],
      );
      if (updatedUserModel != null) {
        await repository.updateUser(updatedUserModel);
        emit(UserProfileSuccess(user: updatedUserModel.toEntity()));
      } else {
        throw Exception('couldn\'t update profile');
      }
    } catch (e) {
      emit(UserProfileFailure(errorMessage: e.toString()));
    }
  }
}
