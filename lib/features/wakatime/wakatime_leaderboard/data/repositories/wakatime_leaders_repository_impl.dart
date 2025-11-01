import 'package:dio/dio.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/data/models/leader_model.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/leader.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/repositories/wakatime_leaders_repository.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class WakatimeLeadersRepositoryImpl implements WakatimeLeadersRepository {
  final Dio dio;
  final SecureStorageRepository storageRepository;
  const WakatimeLeadersRepositoryImpl({
    required this.dio,
    required this.storageRepository,
  });
  @override
  Future<List<Leader>> getLeaders() async {
    final accessToken = storageRepository.read(key: 'access_token');
    try {
      final response = await dio.get(
        "https://wakatime.com/api/leaders",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
        final List<Leader> leaders = [];
        final data = response.data['data'] as List<Map<String, dynamic>>;
        for (Map<String, dynamic> leaderJson in data) {
          leaders.add(LeaderModel.fromJson(leaderJson).toEntity());
        }
        return leaders;
      }
      throw Exception('could\'t get leaders: ${response.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Leader>> getLeadersByCountry(String countryCode) async {
    final accessToken = storageRepository.read(key: 'access_token');
    try {
      final response = await dio.get(
        "https://wakatime.com/api/leaders",
        queryParameters: {"country_code": countryCode},
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
        final List<Leader> leaders = [];
        final data = response.data['data'] as List<Map<String, dynamic>>;
        for (Map<String, dynamic> leaderJson in data) {
          leaders.add(LeaderModel.fromJson(leaderJson).toEntity());
        }
        return leaders;
      }
      throw Exception('could\'t get leaders: ${response.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }
}
