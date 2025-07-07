part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthRegistrationLoading extends AuthState {}

final class AuthRegistrationSuccess extends AuthState {
  final UserCredential credential;
  AuthRegistrationSuccess({required this.credential});
}

final class AuthLoginSuccess extends AuthState {
  final UserCredential credential;
  AuthLoginSuccess({required this.credential});
}

final class AuthFailure extends AuthState {
  SignUpWithEmailAndPasswordFailure failure;

  AuthFailure([this.failure = const SignUpWithEmailAndPasswordFailure()]);
}
