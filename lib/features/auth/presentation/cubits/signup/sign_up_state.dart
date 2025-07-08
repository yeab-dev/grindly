part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, loading, success, failure }

@immutable
class SignUpState extends Equatable {
  final SignUpStatus status;
  final User? user;
  final AuthFailure? failure;

  const SignUpState({
    this.status = SignUpStatus.initial,
    this.user,
    this.failure,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    User? user,
    AuthFailure? failure,
  }) {
    return SignUpState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, user, failure];
}
