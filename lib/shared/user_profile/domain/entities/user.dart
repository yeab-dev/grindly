import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/country.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/wakatime_user.dart';
import 'package:grindly/shared/user_profile/domain/entities/social_media_account.dart';

enum PhotoSource {
  google(name: 'google'),
  wakatime(name: 'wakatime');

  final String name;
  const PhotoSource({required this.name});
}

class User {
  final String uid;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final String? bio;
  final String? photoUrl;
  final List<SocialMediaAccount> socialMediaAccounts;
  final String? wakatimeProfilePictureUrl;
  final String? wakatimeId;
  final Country? country;
  final WakatimeUser? wakatimeAccount;
  final List<User> followers;
  final List<User> following;

  const User({
    required this.uid,
    required this.email,
    required this.createdAt,
    required this.displayName,
    required this.following,
    required this.followers,
    required this.socialMediaAccounts,
    this.wakatimeAccount,
    this.wakatimeId,
    this.country,
    this.bio,
    this.photoUrl,
    this.wakatimeProfilePictureUrl,
  });
}
