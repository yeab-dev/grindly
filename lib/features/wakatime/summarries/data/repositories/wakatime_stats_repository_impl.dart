import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grindly/features/wakatime/stats/data/models/todays_summarries_model.dart';
import 'package:grindly/features/wakatime/stats/domain/entities/todays_summarries.dart';
import 'package:grindly/features/wakatime/stats/domain/repositories/wakatime_summarries_repository.dart';
import 'package:intl/intl.dart';

class WakatimeSummarriesRepositoryImpl implements WakatimeSummarriesRepository {
  final Dio dio;
  const WakatimeSummarriesRepositoryImpl({required this.dio});
  @override
  Future<TodaysSummarries> getTodaysSummarries() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      final response = await dio.get(
        "api/v1/users/current/summaries",
        queryParameters: {"start": today, "end": today},
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
      throw Exception('Network Error ${e.message}');
    } catch (e, stack) {
      log('Unexpected error $e, $stack');
      rethrow;
    }
  }
}
