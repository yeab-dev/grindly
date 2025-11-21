import 'package:firebase_auth/firebase_auth.dart';
import 'package:grindly/core/locator.dart';
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

  factory LeaderModel.fromMap({required Map<String, dynamic> map}) {
    return LeaderModel(
      displayName: map['display_name'],
      rank: 0,
      wakatimeID: map['wakatime_id'],
      photoPublic: map['photo_public'],
      photoUrl: map['photo_url'],
      totalHoursInSeconds: map['seconds'],
      countryModel: CountryModel.fromJson(map['country']),
      grindlyID: map['grindly_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "country": countryModel?.toMap(),
      "display_name": displayName,
      "wakatime_id": wakatimeID,
      "grindly_id": getIt<FirebaseAuth>().currentUser?.uid,
      "photo_url": photoUrl,
      "seconds": totalHoursInSeconds,
      "photo_public": photoPublic,
    };
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
