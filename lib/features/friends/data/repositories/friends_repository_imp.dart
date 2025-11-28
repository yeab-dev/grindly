import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grindly/features/friends/domain/repositories/friends_repository.dart';

class FriendsRepositoryImp implements FriendsRepository {
  final FirebaseFirestore firestore;
  const FriendsRepositoryImp({required this.firestore});
  @override
  Future<List<String>> getFollowerIDs({required String uid}) async {
    final followersSnap = await firestore
        .collection('users')
        .doc(uid)
        .collection('followers')
        .get();

    return followersSnap.docs.map((doc) => doc.id).toList();
  }

  @override
  Future<List<String>> getFollowingIDs({required String uid}) async {
    final followingSnap = await firestore
        .collection('users')
        .doc(uid)
        .collection('following')
        .get();
    return followingSnap.docs.map((doc) => doc.id).toList();
  }
}
