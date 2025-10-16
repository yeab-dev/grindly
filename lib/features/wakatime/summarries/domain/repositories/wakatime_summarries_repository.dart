import 'package:grindly/features/wakatime/stats/domain/entities/todays_summarries.dart';

abstract class WakatimeSummarriesRepository {
  Future<TodaysSummarries> getTodaysSummarries();
}
