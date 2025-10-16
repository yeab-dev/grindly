import 'package:grindly/features/wakatime/summarries/domain/entities/todays_summarries.dart';

abstract class WakatimeSummarriesRepository {
  Future<TodaysSummarries> getTodaysSummarries();
}
