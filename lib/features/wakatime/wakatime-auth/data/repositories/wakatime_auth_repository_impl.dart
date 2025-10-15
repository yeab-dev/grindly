import 'package:dio/dio.dart';
import 'package:grindly/features/wakatime/wakatime-auth/data/models/wakatime_auth_token_model.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_auth_token.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_scope.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/repositories/wakatime_auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class WakatimeAuthRepositoryImpl implements WakatimeAuthRepository {
  final Dio dio;
  final String clientId;
  final String clientSecret;
  final String redirectUri;

  const WakatimeAuthRepositoryImpl({
    required this.dio,
    required this.clientId,
    required this.clientSecret,
    required this.redirectUri,
  });
  @override
  Future<void> authorize({required List<WakaTimeScope> scopes}) async {
    final scopeString = scopes.map((scope) => scope.value).join(',');
    final authUrl = Uri.https('wakatime.com', '/oauth/authorize', {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': 'code',
      'scope': scopeString,
    });

    if (!await launchUrl(authUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch wakatime authorize URL');
    }
  }

  @override
  Future<WakatimeAuthToken> getAccessToken({required String code}) async {
    final response = await dio.post(
      'https://wakatime.com/oauth/token',
      data: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': redirectUri,
        'grant_type': 'authorization_code',
        'code': code,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain,
      ),
    );

    final map = Uri.splitQueryString(response.data);
    final model = WakatimeAuthTokenModel.fromJson(json: map);
    return model.toEntity();
  }

  @override
  Future<WakatimeAuthToken> refreshAccessToken({
    required String refreshToken,
  }) async {
    final response = await dio.post(
      "https://wakatime.com/oauth/token",
      data: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': redirectUri,
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain,
      ),
    );

    final map = Uri.splitQueryString(response.data);
    final model = WakatimeAuthTokenModel.fromJson(json: map);
    return model.toEntity();
  }

  @override
  Future<void> revokeToken({required String token}) async {
    await dio.post(
      'https://wakatime.com/oauth/revoke',
      data: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'token': token,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }
}
