import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/leader.dart';

abstract class WakatimeLeadersRepository {
  Future<List<Leader>> getLeaders();
  Future<List<Leader>> getLeadersByCountry(String countryCode);
  Future<void> saveLeaderToFirestore({required Leader leader});
  Future<List<Leader>> getGrindlyLeaders();
}
