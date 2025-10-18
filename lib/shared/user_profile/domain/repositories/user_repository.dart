import 'package:grindly/shared/user_profile/data/models/user_model.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> saveUser(UserModel user);
  Future<User?> getUser(String uid);
  Future<void> updateUser(UserModel user);
}
