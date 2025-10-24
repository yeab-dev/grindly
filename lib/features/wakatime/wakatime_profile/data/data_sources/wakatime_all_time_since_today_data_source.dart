import 'package:dio/dio.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class WakatimeAllTimeSinceTodayDataSource {
  final Dio dio;
  final SecureStorageRepository repository;
  final String _endpoint =
      "https://wakatime.com/api/v1/users/current/all_time_since_today";

  const WakatimeAllTimeSinceTodayDataSource({
    required this.dio,
    required this.repository,
  });

  Future<Duration> getAllTimeWorkDuration() async {
    final accessToken = await repository.read(key: 'access_token');
    try {
      final response = await dio.get(
        _endpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        final allTimeSinceToday = (response.data['data']['digital'] as String)
            .split(':');

        final hours = int.parse((allTimeSinceToday.first));
        final minutes = int.parse(allTimeSinceToday[1]);
        return Duration(hours: hours, minutes: minutes);
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      rethrow;
    }
  }
}
