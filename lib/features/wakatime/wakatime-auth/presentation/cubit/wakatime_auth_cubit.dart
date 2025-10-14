import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_auth_token.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/entities/wakatime_scope.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/repositories/wakatime_auth_repository.dart';

part 'wakatime_auth_state.dart';

class WakatimeAuthCubit extends Cubit<WakatimeAuthState> {
  final WakatimeAuthRepository repository;
  AppLinks? _appLinks;

  WakatimeAuthCubit({required this.repository}) : super(WakatimeAuthInitial());

  Future<void> authorizeApp() async {
    emit(WakatimeAuthInProgress());
    try {
      await repository.authorize(
        scopes: [
          WakaTimeScope.readStatsLanguages,
          WakaTimeScope.readStatsProjects,
          WakaTimeScope.readSummariesLanguages,
          WakaTimeScope.readSummariesProjects,
        ],
      );
      await _listenForAuthCode();
    } on Exception catch (e) {
      emit(WakatimeAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _listenForAuthCode() async {
    _appLinks ??= AppLinks();
    _appLinks!.uriLinkStream.listen((Uri? uri) async {
      if (uri != null && uri.queryParameters.containsKey('code')) {
        final code = uri.queryParameters['code'];
        if (code != null) {
          emit(WakatimeAuthInProgress());
          try {
            final token = await repository.getAccessToken(code: code);
            emit(WakatimeAuthSuccess(token: token));
          } catch (e) {
            rethrow;
          }
        }
      }
    });
  }
}
