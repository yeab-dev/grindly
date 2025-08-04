import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grindly/shared/data/repository/user_repository.dart';
import 'package:grindly/shared/domain/models/user_model.dart';

class UserRemoteRepository implements UserRepository {
  final FirebaseFirestore firestore;
  const UserRemoteRepository({required this.firestore});

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
