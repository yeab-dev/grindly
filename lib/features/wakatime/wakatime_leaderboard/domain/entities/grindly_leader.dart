import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/country.dart';

class GrindlyLeader {
  final String grindlyId;
  final String displayName;
  final String photoUrl;
  final int timeInSeconds;
  final Country? country;

  const GrindlyLeader({
    required this.grindlyId,
    required this.displayName,
    required this.photoUrl,
    required this.timeInSeconds,
    this.country,
  });
}
