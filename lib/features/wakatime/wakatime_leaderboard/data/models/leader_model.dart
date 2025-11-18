import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/leader.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/models/country_model.dart';

class LeaderModel {
  final String? grindlyID;
  final String wakatimeID;
  final String displayName;
  final int rank;
  final String photoUrl;
  final bool photoPublic;
  final int totalHoursInSeconds;
  final CountryModel? countryModel;

  const LeaderModel({
    required this.displayName,
    required this.rank,
    required this.wakatimeID,
    required this.photoPublic,
    required this.photoUrl,
    required this.totalHoursInSeconds,
    this.grindlyID,
    this.countryModel,
  });

  factory LeaderModel.fromJson(Map<String, dynamic> json) {
    return LeaderModel(
      wakatimeID: json['user']['id'],
      displayName: json['user']['display_name'],
      rank: json['rank'],
      photoPublic: json['user']['photo_public'],
      photoUrl: json['user']['photo'],
      countryModel: json['user']['city'] != null
          ? CountryModel.fromJson(json['user']['city'])
          : null,
      totalHoursInSeconds: (json['running_total']['total_seconds'] as double)
          .toInt(),
    );
  }

  Leader toEntity() {
    return Leader(
      wakatimeID: wakatimeID,
      grindlyID: grindlyID,
      displayName: displayName,
      rank: rank,
      photoPublic: photoPublic,
      photoUrl: photoUrl,
      country: countryModel?.toEntity(),
      totalHoursInSeconds: totalHoursInSeconds,
    );
  }
}
