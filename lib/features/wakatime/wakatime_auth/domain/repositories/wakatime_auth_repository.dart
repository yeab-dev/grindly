import 'package:grindly/features/wakatime/wakatime_auth/domain/entities/wakatime_auth_token.dart';
import 'package:grindly/features/wakatime/wakatime_auth/domain/entities/wakatime_scope.dart';

abstract class WakatimeAuthRepository {
  /// Start OAuth authorization
  Future<void> authorize({required List<WakaTimeScope> scopes});

  /// Exchange authorization code for access token
  Future<WakatimeAuthToken> getAccessToken({required String code});

  /// Refresh an expired access token
  Future<WakatimeAuthToken> refreshAccessToken({required String refreshToken});

  /// Revoke an access or refresh token
  Future<void> revokeToken({required String token});
}
