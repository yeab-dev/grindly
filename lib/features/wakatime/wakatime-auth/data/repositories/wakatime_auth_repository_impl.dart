import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_auth_token.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_scope.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/repositories/wakatime_auth_repository.dart';

class WakatimeAuthRepositoryImpl implements WakatimeAuthRepository {
  @override
  Future<void> authorized({required List<WakaTimeScope> scopes}) {
    // TODO: implement authorized
    throw UnimplementedError();
  }

  @override
  Future<WakatimeAuthToken> getAccessToken({required String code}) {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<WakatimeAuthToken> refreshAccessToken({required String refreshToken}) {
    // TODO: implement refreshAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> revokeToken({required String token}) {
    // TODO: implement revokeToken
    throw UnimplementedError();
  }
}
