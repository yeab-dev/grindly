import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';

class User {
  final String uid;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final String? bio;
  final String? photoUrl;
  final WakatimeUser? wakatimeAccount;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.createdAt,
    this.bio,
    this.wakatimeAccount,
    this.photoUrl,
  });
}
