import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/data/models/grindly_leader_model.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/grindly_leader.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/repositories/grindly_leaders_repository.dart';

class GrindlyLeadersRepositoryImpl implements GrindlyLeadersRepository {
  final FirebaseFirestore firestore;
  const GrindlyLeadersRepositoryImpl({required this.firestore});
  @override
  Future<List<GrindlyLeader>> getGrindlyLeaders() async {
    final snapshot = await firestore.collection('leaders').get();
    final leaders = snapshot.docs
        .map((doc) => GrindlyLeaderModel.fromMap(doc.data()).toEntity())
        .toList();
    return leaders;
  }

  @override
  Future<void> saveGrindlyLeader({
    required GrindlyLeaderModel leaderModel,
  }) async {
    final docRef = firestore.collection('leaders').doc(leaderModel.grindlyId);
    await docRef.set(leaderModel.toMap(), SetOptions(merge: true));
  }
}
