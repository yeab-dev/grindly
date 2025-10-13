import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_auth_token.dart';

class WakatimeAuthTokenModel {
  final String accesstToken;
  final String refreshtToken;

  const WakatimeAuthTokenModel({
    required this.accesstToken,
    required this.refreshtToken,
  });

  factory WakatimeAuthTokenModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return WakatimeAuthTokenModel(
      accesstToken: json['access_token'] as String,
      refreshtToken: json['refresh_token'] as String,
    );
  }

  WakatimeAuthToken toEntity() {
    return WakatimeAuthToken(
      accessToken: accesstToken,
      refreshToken: refreshtToken,
    );
  }
}
