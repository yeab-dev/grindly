import 'package:grindly/features/wakatime/wakatime_leaderboard/data/models/leader_model.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/country.dart';

class Leader {
  final String wakatimeID;
  final String? grindlyID;
  final String displayName;
  final int rank;
  final String photoUrl;
  final bool photoPublic;
  final int totalHoursInSeconds;
  final Country? country;

  const Leader({
    required this.displayName,
    required this.rank,
    required this.wakatimeID,
    required this.photoPublic,
    required this.photoUrl,
    required this.totalHoursInSeconds,
    this.country,
    this.grindlyID,
  });

  LeaderModel toModel() {
    return LeaderModel(
      wakatimeID: wakatimeID,
      grindlyID: grindlyID,
      rank: rank,
      displayName: displayName,
      photoPublic: photoPublic,
      photoUrl: photoUrl,
      totalHoursInSeconds: totalHoursInSeconds,
      countryModel: country?.toModel(),
    );
  }
}
