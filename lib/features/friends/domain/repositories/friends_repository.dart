abstract class FriendsRepository {
  Future<List<String>> getFollowerIDs({required String uid});
  Future<List<String>> getFollowingIDs({required String uid});
}
