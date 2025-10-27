import 'package:grindly/shared/user_profile/domain/entities/social_media_account.dart';

class SocialMediaAccountModel {
  final String platformName;
  final String url;

  const SocialMediaAccountModel({
    required this.platformName,
    required this.url,
  });

  factory SocialMediaAccountModel.fromMap({required Map<String, dynamic> map}) {
    return SocialMediaAccountModel(
      platformName: map['platform_name'],
      url: map['url'],
    );
  }
  Map<String, dynamic> toMap() {
    return {"platform_name": platformName, "url": url};
  }

  SocialMediaAccount toEntity({required String assetLocation}) {
    return SocialMediaAccount(
      platformName: platformName,
      platformLogo: assetLocation,
      url: url,
    );
  }
}
