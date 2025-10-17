import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grindly/features/wakatime/summarries/data/models/todays_summarries_model.dart';
import 'package:grindly/features/wakatime/summarries/domain/entities/todays_summarries.dart';
import 'package:grindly/features/wakatime/summarries/domain/repositories/wakatime_summarries_repository.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';
import 'package:intl/intl.dart';

class WakatimeSummariesRepositoryImpl implements WakatimeSummariesRepository {
  final Dio dio;
  final SecureStorageRepository storageRepository;
  const WakatimeSummariesRepositoryImpl({
    required this.dio,
    required this.storageRepository,
  });
  @override
  Future<TodaysSummarries> getTodaysSummarries() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final accessToken = await storageRepository.read(key: 'access_token');
    try {
      final response = await dio.get(
        "https://wakatime.com/api/v1/users/current/summaries",
        queryParameters: {"start": today, "end": today},
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>?;
        if (data == null || data.isEmpty) {
          throw Exception('No summaries found for today.');
        }

        final firstItem = data.first as Map<String, dynamic>;
        final model = TodaysSummarriesModel.fromJson(json: firstItem);
        return model.toEntity();
      } else {
        throw Exception(
          'couldn\'t fetch summarries: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network Error ${e.toString()}');
    } catch (e, stack) {
      log('Unexpected error $e, $stack');
      rethrow;
    }
  }
}
