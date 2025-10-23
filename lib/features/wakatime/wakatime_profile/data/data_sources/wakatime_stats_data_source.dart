import 'package:dio/dio.dart';
import 'package:grindly/shared/domain/entities/project.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class WakatimeStatsDataSource {
  final Dio dio;
  final String _endpoint =
      "https://wakatime.com/api/v1/users/current/stats/all_time";
  final SecureStorageRepository repository;

  const WakatimeStatsDataSource({required this.dio, required this.repository});

  Future<Map<Project, Duration>> getProjectsWithTimeSpent() async {
    final accessToken = await repository.read(key: 'access_token');
    try {
      final response = await dio.get(
        _endpoint,
        queryParameters: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final Map<Project, Duration> result = {};
        final List<Map<String, dynamic>> timeSpentOnProjects =
            response.data['data']['projects'];

        for (Map<String, dynamic> projectAndDuration in timeSpentOnProjects) {
          String name = projectAndDuration['name'];
          final digitalDuration = (projectAndDuration['digital'] as String)
              .split(':');
          final hours = int.parse(digitalDuration[0]);
          final minutes = int.parse(digitalDuration[1]);
          final project = Project(
            name: name,
            timeSpentAllTime: Duration(hours: hours, minutes: minutes),
          );

          result[project] = Duration(hours: hours, minutes: minutes);
        }
        return result;
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Duration>> getLanguagesWithTimeSpent() async {
    try {
      final accessToken = await repository.read(key: 'access_token');
      final response = await dio.get(
        _endpoint,
        queryParameters: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final Map<String, Duration> result = {};
        final List<Map<String, dynamic>> languagesWithDuration =
            response.data['languages'];

        for (Map<String, dynamic> languageWithDuration
            in languagesWithDuration) {
          final name = languageWithDuration['name'];
          final timeSpentDigital = languageWithDuration['digital'] as String;
          final duration = timeSpentDigital.split(':');
          final hours = int.parse(duration[0]);
          final minutes = int.parse(duration[1]);
          result[name] = Duration(hours: hours, minutes: minutes);
        }
        return result;
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      rethrow;
    }
  }
}
