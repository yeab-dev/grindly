import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  const AuthRepository({required this.firebaseAuth});

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> sendEmailVerification() async {
    final user = getCurrentUser();
    if (user != null) {
      user.sendEmailVerification();
    } else {
      throw Exception('please signup first');
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<UserCredential> continueWithGoogle() async {
    // Implement Google Sign-In logic here
    throw UnimplementedError('Google Sign-In not implemented yet');
  }
}
