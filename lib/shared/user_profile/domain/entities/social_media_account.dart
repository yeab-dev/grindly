import 'package:grindly/shared/user_profile/data/models/social_media_account.model.dart';

class SocialMediaAccount {
  final String url;
  final String platformLogo;
  final String platformName;

  const SocialMediaAccount({
    required this.platformName,
    required this.platformLogo,
    required this.url,
  });

  SocialMediaAccountModel toModel() {
    return SocialMediaAccountModel(platformName: platformName, url: url);
  }
}
