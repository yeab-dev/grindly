import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_auth_token.dart';

class WakatimeAuthTokenModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final DateTime expiresAt;
  final int expiresIn;
  final String scope;
  final String uid;

  const WakatimeAuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresAt,
    required this.expiresIn,
    required this.scope,
    required this.uid,
  });

  /// Factory constructor to parse JSON
  factory WakatimeAuthTokenModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return WakatimeAuthTokenModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      expiresIn: int.parse(json['expires_in'] as String),
      scope: json['scope'] as String,
      uid: json['uid'] as String,
    );
  }

  /// Convert model to domain entity
  WakatimeAuthToken toEntity() {
    return WakatimeAuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresAt: expiresAt,
      expiresIn: expiresIn,
      scope: scope,
      uid: uid,
    );
  }

  /// Optional: convert entity to JSON (for secure storage or logging)
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_at': expiresAt.toIso8601String(),
      'expires_in': expiresIn,
      'scope': scope,
      'uid': uid,
    };
  }
}
