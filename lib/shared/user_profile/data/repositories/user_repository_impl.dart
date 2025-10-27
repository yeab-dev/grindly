import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';
import 'package:grindly/shared/user_profile/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;
  const UserRepositoryImpl({required this.firestore});

  @override
  Future<UserModel?> getUser(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.exists ? UserModel.fromMap(doc.data()!) : null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).update(user.toMap());
  }
}
