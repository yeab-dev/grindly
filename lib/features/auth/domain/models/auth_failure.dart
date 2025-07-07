class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = "Something went wrong please try again later",
  ]);
  final String message;

  factory SignUpWithEmailAndPasswordFailure.withCode(String code) {
    switch (code) {
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'your account has been disabled. please contact support for help',
        );
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'email not valid or badly formatted',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'an account already exists with the email provided',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'operation not allowed. please contact support for help',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'please enter a strong password',
        );
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}
