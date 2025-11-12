import 'package:grindly/features/wakatime/wakatime_leaderboard/data/models/grindly_leader_model.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/grindly_leader.dart';

abstract class GrindlyLeadersRepository {
  Future<List<GrindlyLeader>> getGrindlyLeaders();
  Future<void> saveGrindlyLeader({required GrindlyLeaderModel leaderModel});
}
