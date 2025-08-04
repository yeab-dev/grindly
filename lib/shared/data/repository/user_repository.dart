import 'package:grindly/shared/domain/models/user_model.dart';

abstract class UserRepository {
  Future<void> saveUser(UserModel user);
  Future<void> getUser(String uid);
  Future<void> updateUser(UserModel user);
}
