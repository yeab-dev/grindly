import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/country.dart';

class WakatimeUser {
  final String id;
  final String photoUrl;
  final Country? country;
  final Map<String, dynamic> bestProjectWithDuration;
  final Map<String, dynamic> bestWeekDayWithDuration;
  final Map<String, dynamic> bestLanguageWithDuration;
  final Duration totalTime;
  const WakatimeUser({
    required this.id,
    required this.photoUrl,
    required this.bestLanguageWithDuration,
    required this.bestProjectWithDuration,
    required this.bestWeekDayWithDuration,
    required this.totalTime,
    this.country,
  });
}
