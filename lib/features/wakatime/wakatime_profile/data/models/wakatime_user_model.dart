import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';

class WakatimeUserModel {
  final String photoUrl;
  final Duration bestProjectByDuration;
  final Duration bestWeekDayByDuration;
  final Duration bestLanguageByDuration;
  final Duration totalTime;

  const WakatimeUserModel({
    required this.photoUrl,
    required this.totalTime,
    required this.bestLanguageByDuration,
    required this.bestProjectByDuration,
    required this.bestWeekDayByDuration,
  });

  factory WakatimeUserModel.fromJson(Map<String, dynamic> json) {
    return WakatimeUserModel(
      photoUrl: json['photo_url'],
      totalTime: json['total_time'],
      bestLanguageByDuration: json['languages_with_hours_spent'],
      bestProjectByDuration: json['projects_with_hours_spent'],
      bestWeekDayByDuration: json['week_days_with_hours_spent'],
    );
  }

  WakatimeUser toEntity() {
    return WakatimeUser(
      photoUrl: photoUrl,
      totalTime: totalTime,
      bestLanguageByDuration: bestLanguageByDuration,
      bestWeekDayByDuration: bestWeekDayByDuration,
      bestProjectByDuration: bestProjectByDuration,
    );
  }
}
