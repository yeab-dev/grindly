part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignInLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final UserCredential credential;
  AuthSignUpSuccess({required this.credential});
}

final class AuthLoginSuccess extends AuthState {
  final UserCredential credential;
  AuthLoginSuccess({required this.credential});
}

final class AuthSignUpFailure extends AuthState {
  final SignUpWithEmailAndPasswordFailure signUpFailure;

  AuthSignUpFailure([
    this.signUpFailure = const SignUpWithEmailAndPasswordFailure(),
  ]);
}

final class AuthSignInFailure extends AuthState {
  AuthSignInFailure([
    this.signInFailure = const SignInWithEmailAndPasswordFailure(),
  ]);
  final SignInWithEmailAndPasswordFailure signInFailure;
}
