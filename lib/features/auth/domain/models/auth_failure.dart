abstract class AuthFailure implements Exception {
  final String message;
  const AuthFailure({required this.message});

  @override
  String toString() => message;
}

class SignUpWithEmailAndPasswordFailure extends AuthFailure {
  const SignUpWithEmailAndPasswordFailure([
    String message = "Something went wrong, please try again later.",
  ]) : super(message: message);

  /// Creates a failure based on Firebase error codes.
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'Your account has been disabled. Please contact support for help.',
        );
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email not valid or badly formatted.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists with the provided email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation not allowed. Please contact support for help.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class SignInWithEmailAndPasswordFailure extends AuthFailure {
  const SignInWithEmailAndPasswordFailure([
    String message = 'Something went wrong!',
  ]) : super(message: message);

  /// Creates a failure based on Firebase error codes.
  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const SignInWithEmailAndPasswordFailure(
          'Wrong email or password.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'Your account has been disabled. Please contact support for help.',
        );
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'Email not valid or badly formatted.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }
}
