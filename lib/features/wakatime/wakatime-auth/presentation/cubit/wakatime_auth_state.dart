part of 'wakatime_auth_cubit.dart';

sealed class WakatimeAuthState extends Equatable {
  const WakatimeAuthState();

  @override
  List<Object> get props => [];
}

final class WakatimeAuthInitial extends WakatimeAuthState {}

final class WakatimeAuthInProgress extends WakatimeAuthState {}

final class WakatimeAuthSuccess extends WakatimeAuthState {
  final WakatimeAuthToken token;
  const WakatimeAuthSuccess({required this.token});
}

final class WakatimeAuthFailure extends WakatimeAuthState {
  final String errorMessage;
  const WakatimeAuthFailure({required this.errorMessage});
}
