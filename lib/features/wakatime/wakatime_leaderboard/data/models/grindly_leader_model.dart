import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/grindly_leader.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/models/country_model.dart';

class GrindlyLeaderModel {
  final String grindlyId;
  final String displayName;
  final String photoUrl;
  final int timeInSeconds;
  final CountryModel? country;

  const GrindlyLeaderModel({
    required this.grindlyId,
    required this.displayName,
    required this.photoUrl,
    required this.timeInSeconds,
    this.country,
  });

  factory GrindlyLeaderModel.fromMap(Map<String, dynamic> map) {
    return GrindlyLeaderModel(
      grindlyId: map['id'],
      displayName: map['display_name'],
      photoUrl: map['photo_url'],
      timeInSeconds: map['seconds'],
      country: map.containsKey('country')
          ? CountryModel.fromJson(map['country'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": grindlyId,
      "display_name": displayName,
      "photo_url": photoUrl,
      "seconds": timeInSeconds,
      "country": country?.toMap(),
    };
  }

  GrindlyLeader toEntity() {
    return GrindlyLeader(
      grindlyId: grindlyId,
      displayName: displayName,
      photoUrl: photoUrl,
      timeInSeconds: timeInSeconds,
      country: country?.toEntity(),
    );
  }
}
