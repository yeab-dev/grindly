import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/shared/domain/repositories/entities/project.dart';

class WakatimeUserModel {
  final String photoUrl;
  final Map<Project, Duration> projectsWithHoursSpent;
  final Map<int, Duration> weekdaysWithHoursSpent;
  final Map<String, Duration> languagesWithHoursSpent;
  final Duration totalTime;

  const WakatimeUserModel({
    required this.photoUrl,
    required this.totalTime,
    required this.languagesWithHoursSpent,
    required this.projectsWithHoursSpent,
    required this.weekdaysWithHoursSpent,
  });

  factory WakatimeUserModel.fromJson(Map<String, dynamic> json) {
    return WakatimeUserModel(
      photoUrl: json['photo_url'],
      totalTime: json['total_time'],
      languagesWithHoursSpent: json['languages_with_hours_spent'],
      projectsWithHoursSpent: json['projects_with_hours_spent'],
      weekdaysWithHoursSpent: json['week_days_with_hours_spent'],
    );
  }

  WakatimeUser toEntity() {
    return WakatimeUser(
      photoUrl: photoUrl,
      totalTime: totalTime,
      projectsWithHoursSpent: projectsWithHoursSpent,
      weekdaysWithHoursSpent: weekdaysWithHoursSpent,
    );
  }
}
