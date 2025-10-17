import 'package:grindly/features/wakatime/summarries/domain/entities/todays_summarries.dart';

abstract class WakatimeSummariesRepository {
  Future<TodaysSummarries> getTodaysSummarries();
}
