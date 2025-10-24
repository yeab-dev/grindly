import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';

class User {
  final String uid;
  final String email;
  final String displayName;
  final String? username;
  final String? photoUrl;
  final DateTime createdAt;
  final WakatimeUser? wakatimeAccount;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.createdAt,
    this.wakatimeAccount,
    this.username,
    this.photoUrl,
  });
}
