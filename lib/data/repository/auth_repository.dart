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
}
