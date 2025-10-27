import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/shared/user_profile/domain/entities/social_media_account.dart';

class User {
  final String uid;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final String? bio;
  final String? photoUrl;
  final WakatimeUser? wakatimeAccount;
  final List<SocialMediaAccount>? socialMediaAccounts;

  const User({
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.displayName,
    this.bio,
    this.photoUrl,
    this.wakatimeAccount,
    this.socialMediaAccounts,
  });
}
