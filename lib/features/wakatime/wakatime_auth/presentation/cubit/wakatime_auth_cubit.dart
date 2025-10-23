import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grindly/features/wakatime/wakatime_auth/domain/entities/wakatime_auth_token.dart';
import 'package:grindly/features/wakatime/wakatime_auth/domain/entities/wakatime_scope.dart';
import 'package:grindly/features/wakatime/wakatime_auth/domain/repositories/wakatime_auth_repository.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

part 'wakatime_auth_state.dart';

class WakatimeAuthCubit extends Cubit<WakatimeAuthState> {
  final WakatimeAuthRepository repository;
  final SecureStorageRepository storageRepository;
  AppLinks? _appLinks;

  WakatimeAuthCubit({required this.repository, required this.storageRepository})
    : super(WakatimeAuthInitial());

  Future<void> authorizeApp() async {
    emit(WakatimeAuthInProgress());
    try {
      await repository.authorize(scopes: [WakaTimeScope.readSummaries]);
      await _listenForAuthCode();
    } on Exception catch (e) {
      emit(WakatimeAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _listenForAuthCode() async {
    _appLinks ??= AppLinks();
    _appLinks!.uriLinkStream.listen(_handleIncomingLink);
  }

  Future<void> _handleIncomingLink(Uri? uri) async {
    if (uri == null) return;

    // Parse existing tokens first and use them if they're not expired
    final existingExpirationDate = await storageRepository.read(
      key: 'expires_at',
    );
    if (existingExpirationDate != null &&
        DateTime.now().isBefore(DateTime.parse(existingExpirationDate))) {
      final date = DateTime.parse(existingExpirationDate);
      final existingAccess = await storageRepository.read(key: 'access_token');
      final existingRefresh = await storageRepository.read(
        key: 'refresh_token',
      );
      if (existingAccess != null && existingRefresh != null) {
        emit(
          WakatimeAuthSuccess(
            token: WakatimeAuthToken(
              accessToken: existingAccess,
              refreshToken: existingRefresh,
              expiresAt: date,
            ),
          ),
        );
        return;
      }
    }

    // Otherwise, handle code from redirect
    if (uri.queryParameters.containsKey('code')) {
      final code = uri.queryParameters['code']!;
      emit(WakatimeAuthInProgress());
      try {
        final token = await repository.getAccessToken(code: code);

        await storageRepository.write(
          key: "access_token",
          value: token.accessToken,
        );
        await storageRepository.write(
          key: 'refresh_token',
          value: token.refreshToken,
        );

        await storageRepository.write(
          key: 'expires_at',
          value: token.expiresAt.toIso8601String(),
        );

        emit(WakatimeAuthSuccess(token: token));
      } catch (e) {
        emit(WakatimeAuthFailure(errorMessage: e.toString()));
      }
    }
  }
}
