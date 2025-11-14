import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/country.dart';

class Leader {
  final String userId;
  final String displayName;
  final int rank;
  final String photoUrl;
  final bool photoPublic;
  final int totalHourInSeconds;
  final Country? country;

  const Leader({
    required this.userId,
    required this.displayName,
    required this.rank,
    required this.photoPublic,
    required this.photoUrl,
    required this.totalHourInSeconds,
    this.country,
  });
}
