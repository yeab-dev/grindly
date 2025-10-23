import 'package:dio/dio.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/converters.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

class WakatimeInsightDataSource {
  final Dio dio;
  final String _endpoint =
      "https://wakatime.com/api/v1/users/current/insights/weekdays/last_year";
  final SecureStorageRepository storageRepository;

  const WakatimeInsightDataSource({
    required this.dio,
    required this.storageRepository,
  });

  Future<Map<String, Duration>> getTotalTimeSpentOnWeekDays() async {
    final token = await storageRepository.read(key: 'access_token');
    try {
      final response = await dio.get(
        _endpoint,
        queryParameters: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        final Map<String, Duration> result = {};
        final List<Map<String, dynamic>> timeSpentOnWeekDays =
            response.data['data']['weekdays'];
        for (Map<String, dynamic> weekdayData in timeSpentOnWeekDays) {
          final name = weekdayData['name'] as String;
          final total = weekdayData['total'];
          result[name] = Converters.toDuration((total as num).toDouble());
        }
        return result;
      }
      // return empty map if response is not OK
      return {};
    } catch (e) {
      rethrow;
    }
  }
}
