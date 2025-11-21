import 'package:grindly/shared/user_profile/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(String uid);
  Future<void> updateUser(UserModel user);
  Future<void> follow({
    required String followingUserId,
    required String followedUserId,
  });
}
