part of 'sign_in_cubit.dart';

enum SignInStatus { initial, loading, success, failure }

@immutable
class SignInState extends Equatable {
  const SignInState({
    this.status = SignInStatus.initial,
    this.user,
    this.failure,
  });
  final SignInStatus status;
  final User? user;
  final AuthFailure? failure;

  SignInState copyWith({
    SignInStatus? status,
    User? user,
    AuthFailure? failure,
  }) {
    return SignInState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, user, failure];
}
