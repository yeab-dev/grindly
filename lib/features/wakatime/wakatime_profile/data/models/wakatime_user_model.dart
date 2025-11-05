import 'package:grindly/features/wakatime/wakatime_profile/data/models/country_model.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';

class WakatimeUserModel {
  final String id;
  final String photoUrl;
  final Map<String, dynamic> bestProjectByDuration;
  final Map<String, dynamic> bestWeekDayByDuration;
  final Map<String, dynamic> bestLanguageByDuration;
  final Duration totalTime;
  final CountryModel? countryModel;

  const WakatimeUserModel({
    required this.id,
    required this.photoUrl,
    required this.totalTime,
    required this.bestLanguageByDuration,
    required this.bestProjectByDuration,
    required this.bestWeekDayByDuration,
    this.countryModel,
  });

  factory WakatimeUserModel.fromJson(Map<String, dynamic> json) {
    return WakatimeUserModel(
      id: json['basic_info']['id'],
      photoUrl: json['basic_info']['photo_url'],
      totalTime: json['total_time'],
      bestLanguageByDuration: json['languages_with_hours_spent'],
      bestProjectByDuration: json['projects_with_hours_spent'],
      bestWeekDayByDuration: json['weekdays_with_hours_spent'],
      countryModel: json['basic_info'].containsKey("country")
          ? CountryModel.fromJson(json['basic_info']['country'])
          : null,
    );
  }

  WakatimeUser toEntity() {
    return WakatimeUser(
      id: id,
      photoUrl: photoUrl,
      totalTime: totalTime,
      bestLanguageWithDuration: bestLanguageByDuration,
      bestWeekDayWithDuration: bestWeekDayByDuration,
      bestProjectWithDuration: bestProjectByDuration,
      country: countryModel?.toEntity(),
    );
  }
}
