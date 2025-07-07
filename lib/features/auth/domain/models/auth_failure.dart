class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = "Something went wrong please try again later",
  ]);
  final String message;

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
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

class SignInWithEmailAndPasswordFailure implements Exception {
  const SignInWithEmailAndPasswordFailure([
    this.message = 'something went wrong!',
  ]);

  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return SignInWithEmailAndPasswordFailure('wrong email or password');
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'your account has been disabled. please contact support for help',
        );
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'email not valid or badly formatted',
        );
      default:
        return SignInWithEmailAndPasswordFailure();
    }
  }
  final String message;
}
