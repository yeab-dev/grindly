import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/converters.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/models/country_model.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/shared/domain/entities/project.dart';

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
      countryModel:
          json['basic_info'].containsKey("country") &&
              json['basic_info']['country'] != null
          ? CountryModel.fromJson(json['basic_info']['country'])
          : null,
    );
  }
  factory WakatimeUserModel.fromMap(Map<String, dynamic> map) {
    final totalSeconds = (map['total_time'] as int?) ?? 0;
    final totalTime = Converters.toDuration(totalSeconds.toDouble());

    final bestLangMap =
        (map['best_language'] as Map?)?.cast<String, dynamic>() ?? {};
    final bestLanguage = {
      'name': (bestLangMap['name'] as String?) ?? '',
      'duration': Converters.toDuration(
        (bestLangMap['duration'] as int?)?.toDouble() ?? 0,
      ),
    };

    final bestWeekMap =
        (map['best_weekday'] as Map?)?.cast<String, dynamic>() ?? {};
    final bestWeekDay = {
      'name': (bestWeekMap['name'] as String?) ?? '',
      'duration': Converters.toDuration(
        (bestWeekMap['duration'] as int?)?.toDouble() ?? 0,
      ),
    };

    final bestProjectMap =
        (map['best_project'] as Map?)?.cast<String, dynamic>() ?? {};
    final projectName = (bestProjectMap['name'] as String?) ?? '';
    final projectDurationSeconds = bestProjectMap['duration'] as int?;
    final project = Project(
      name: projectName,
      timeSpentAllTime: projectDurationSeconds != null
          ? Converters.toDuration(projectDurationSeconds.toDouble())
          : null,
    );
    final bestProject = {'project': project};

    return WakatimeUserModel(
      id: map['uid'],
      photoUrl: map['photo_url'],
      totalTime: totalTime,
      bestLanguageByDuration: bestLanguage,
      bestProjectByDuration: bestProject,
      bestWeekDayByDuration: bestWeekDay,
      countryModel: null,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'total_time': totalTime.inSeconds,
      'best_language': {
        "name": bestLanguageByDuration['name'],
        "duration": (bestLanguageByDuration['duration'] as Duration).inSeconds,
      },
      'best_project': {
        "name": (bestProjectByDuration['project'] as Project).name,
        "duration": (bestProjectByDuration['project'] as Project)
            .timeSpentAllTime
            ?.inSeconds,
      },
      'best_weekday': {
        "name": bestWeekDayByDuration['name'],
        "duration": (bestWeekDayByDuration['duration'] as Duration).inSeconds,
      },
    };
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
