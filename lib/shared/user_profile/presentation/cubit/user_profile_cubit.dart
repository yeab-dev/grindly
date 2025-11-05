import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/repositories/wakatime_profile_repository.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';
import 'package:grindly/shared/user_profile/data/models/social_media_account.model.dart';
import 'package:grindly/shared/user_profile/data/models/user_model.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart'
    as grindly_user;
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserRepository repository;
  final WakatimeProfileRepository wakatimeRepository;
  final SecureStorageRepository storageRepository;
  UserProfileCubit({
    required this.repository,
    required this.wakatimeRepository,
    required this.storageRepository,
  }) : super(UserProfileInitial());

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
      UserModel? grindlyUser = await repository.getUser(uid);
      final wakatimeAccount = await wakatimeRepository.getUserData();
      grindlyUser = grindlyUser!.copyWith(wakatimeAccount: wakatimeAccount);
      await repository.updateUser(grindlyUser);
      await storageRepository.write(
        key: "country_code",
        value: wakatimeAccount.country != null
            ? wakatimeAccount.country!.countryCode
            : "NW",
      );
      await storageRepository.write(
        key: "country_name",
        value: wakatimeAccount.country != null
            ? wakatimeAccount.country!.countryName
            : "Nowhere",
      );
      emit(UserProfileSuccess(user: grindlyUser.toEntity()));
    } catch (e) {
      emit(UserProfileFailure(errorMessage: 'Could\'t get profile info'));
    }
  }

  Future<void> updateUser({
    String? displayName,
    String? bio,
    String? xLink,
    String? telegramLink,
    grindly_user.PhotoSource? photoSrc,
    required grindly_user.User previous,
  }) async {
    emit(UserProfileInProgress());
    try {
      final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();
      final uid = firebaseAuth.currentUser!.uid;
      UserModel? userModel = await repository.getUser(uid);
      final updatedUserModel = userModel?.copyWith(
        displayName: displayName,
        bio: bio,
        socialMediaAccounts: (xLink == null && telegramLink == null)
            ? null
            : <SocialMediaAccountModel>[
                if (xLink != null)
                  SocialMediaAccountModel(platformName: 'X', url: xLink),
                if (telegramLink != null)
                  SocialMediaAccountModel(
                    platformName: 'Telegram',
                    url: telegramLink,
                  ),
              ],
        wakatimeAccount: previous.wakatimeAccount,
        photoUrl: photoSrc == grindly_user.PhotoSource.google
            ? firebaseAuth.currentUser!.photoURL
            : previous.wakatimeAccount?.photoUrl,
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
