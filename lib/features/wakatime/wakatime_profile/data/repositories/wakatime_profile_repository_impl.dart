import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_all_time_since_today_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_insight_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_basic_info_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_stats_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/models/wakatime_user_model.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/repositories/wakatime_profile_repository.dart';

class WakatimeProfileRepositoryImpl implements WakatimeProfileRepository {
  final WakatimeAllTimeSinceTodayDataSource allTimeSinceTodayDataSource;
  final WakatimeInsightDataSource insightDataSource;
  final WakatimeBasicInfoDataSource basicInfoDataSource;
  final WakatimeStatsDataSource statsDataSource;

  const WakatimeProfileRepositoryImpl({
    required this.allTimeSinceTodayDataSource,
    required this.insightDataSource,
    required this.basicInfoDataSource,
    required this.statsDataSource,
  });
  @override
  Future<WakatimeUser> getUserData() async {
    final basicInfo = await basicInfoDataSource.getBasicUserInfo();

    final allTimeSinceToday = await allTimeSinceTodayDataSource
        .getAllTimeWorkDuration();

    final projectsWithHoursSpent = await statsDataSource
        .getProjectsWithTimeSpent();

    final languagesWithHoursSpent = await statsDataSource
        .getLanguagesWithTimeSpent();

    final weekdaysWithHoursSpent = await insightDataSource
        .getTotalTimeSpentOnWeekDays();

    final userModel = WakatimeUserModel.fromJson({
      "basic_info": basicInfo,
      "total_time": allTimeSinceToday,
      "languages_with_hours_spent": languagesWithHoursSpent,
      "projects_with_hours_spent": projectsWithHoursSpent,
      "weekdays_with_hours_spent": weekdaysWithHoursSpent,
    });

    return userModel.toEntity();
  }
}
