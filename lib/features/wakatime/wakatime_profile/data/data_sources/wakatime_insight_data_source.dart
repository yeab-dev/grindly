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

  Future<Map<String, dynamic>> getTotalTimeSpentOnWeekDays() async {
    final token = await storageRepository.read(key: 'access_token');
    try {
      final response = await dio.get(
        _endpoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = {};
        final List timeSpentOnWeekDays = response.data['data']['weekdays'];
        final name = timeSpentOnWeekDays[0]['name'] as String;
        final total = timeSpentOnWeekDays[0]['total'];
        result['name'] = name;
        result['duration'] = Converters.toDuration((total as num).toDouble());
        return result;
      }
      throw Exception('Something went wrong');
    } catch (e) {
      rethrow;
    }
  }
}
