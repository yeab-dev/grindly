import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';
import 'package:grindly/shared/user_profile/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;
  const UserRepositoryImpl({required this.firestore});

  @override
  Future<UserModel?> getUser(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    final userModel = doc.exists ? UserModel.fromMap(doc.data()!) : null;
    final followersSnap = await firestore
        .collection('users')
        .doc(uid)
        .collection('followers')
        .get();
    final followingSnap = await firestore
        .collection('users')
        .doc(uid)
        .collection('following')
        .get();
    final followingIDs = followingSnap.docs.map((data) => data.id).toList();
    final followersIDs = followersSnap.docs.map((data) => data.id).toList();

    final updateUserModel = userModel?.copyWith(
      followers: followersIDs,
      following: followingIDs,
    );
    return updateUserModel;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).update(user.toMap());
  }

  @override
  Future<void> follow({
    required String followingUserID,
    required String userBeingFollowedID,
  }) async {
    await firestore
        .collection('users')
        .doc(followingUserID)
        .collection('following')
        .doc(userBeingFollowedID)
        .set({'followedAt': Timestamp.now()});
    await firestore
        .collection('users')
        .doc(userBeingFollowedID)
        .collection('followers')
        .doc(followingUserID)
        .set({"followedAt": Timestamp.now()});
  }

  @override
  Future<void> unfollow({
    required String unfollowingUserID,
    required String userBeingUnfollowedID,
  }) async {
    final followingUser = await getUser(unfollowingUserID);
    final userBeingUnfollowed = await getUser(userBeingUnfollowedID);
    if (followingUser != null && userBeingUnfollowed != null) {
      await firestore
          .collection('users')
          .doc(unfollowingUserID)
          .collection('following')
          .doc(userBeingUnfollowedID)
          .delete();
      await firestore
          .collection('users')
          .doc(userBeingUnfollowedID)
          .collection('followers')
          .doc(unfollowingUserID)
          .delete();
    }
  }
}
