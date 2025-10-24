import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_all_time_since_today_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_insight_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_profile_picture_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_stats_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/repositories/wakatime_profile_repository.dart';

class WakatimeProfileRepositoryImpl implements WakatimeProfileRepository {
  final WakatimeAllTimeSinceTodayDataSource allTimeSinceTodayDataSource;
  final WakatimeInsightDataSource insightDataSource;
  final WakatimeProfilePictureDataSource profilePictureDataSource;
  final WakatimeStatsDataSource statsDataSource;

  const WakatimeProfileRepositoryImpl({
    required this.allTimeSinceTodayDataSource,
    required this.insightDataSource,
    required this.profilePictureDataSource,
    required this.statsDataSource,
  });
  @override
  Future<WakatimeUser> getUserData() async {
    final profilePictureUrl = await profilePictureDataSource
        .getProfilePictureUrl();

    final allTimeSinceToday = await allTimeSinceTodayDataSource
        .getAllTimeWorkDuration();

    final projectsWithHoursSpent = await statsDataSource
        .getProjectsWithTimeSpent();

    final languagesWithHoursSpent = await statsDataSource
        .getLanguagesWithTimeSpent();

    final weekdaysWithHoursSpent = await insightDataSource
        .getTotalTimeSpentOnWeekDays();

    return WakatimeUser(
      bestLanguageWithDuration: languagesWithHoursSpent,
      photoUrl: profilePictureUrl,
      bestProjectWithDuration: projectsWithHoursSpent,
      bestWeekDayWithDuration: weekdaysWithHoursSpent,
      totalTime: allTimeSinceToday,
    );
  }
}
