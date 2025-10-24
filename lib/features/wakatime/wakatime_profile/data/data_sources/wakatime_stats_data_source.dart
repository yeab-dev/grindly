import 'package:dio/dio.dart';
import 'package:grindly/shared/domain/entities/project.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class WakatimeStatsDataSource {
  final Dio dio;
  final String _endpoint =
      "https://wakatime.com/api/v1/users/current/stats/all_time";
  final SecureStorageRepository repository;
  late Response apiResponse;
  WakatimeStatsDataSource({required this.dio, required this.repository});

  Future<Map<String, dynamic>> getProjectsWithTimeSpent() async {
    final accessToken = await repository.read(key: 'access_token');
    try {
      final response = await dio.get(
        _endpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200) {
        apiResponse = response;
        final Map<String, dynamic> result = {};
        final timeSpentOnProjects = response.data['data']['projects'];

        String name = timeSpentOnProjects[0]['name'];
        final digitalDuration = (timeSpentOnProjects[0]['digital'] as String)
            .split(':');
        final hours = int.parse(digitalDuration[0]);
        final minutes = int.parse(digitalDuration[1]);
        final project = Project(
          name: name,
          timeSpentAllTime: Duration(hours: hours, minutes: minutes),
        );

        result['project'] = project;
        return result;
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLanguagesWithTimeSpent() async {
    try {
      final response = apiResponse;
      final Map<String, dynamic> result = {};
      final languagesWithDuration = response.data['data']['languages'];

      final name = languagesWithDuration[0]['name'];
      final timeSpentDigital = languagesWithDuration[0]['digital'] as String;
      final duration = timeSpentDigital.split(':');
      final hours = int.parse(duration[0]);
      final minutes = int.parse(duration[1]);
      result['name'] = name;
      result['duration'] = Duration(hours: hours, minutes: minutes);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
