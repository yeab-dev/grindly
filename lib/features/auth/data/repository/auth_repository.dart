import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<UserCredential> continueWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();

    try {
      final auth = await googleSignIn.authenticate();
      final authentication = auth.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
      );
      return await firebaseAuth.signInWithCredential(credential);
    } on GoogleSignInException catch (_) {
      rethrow;
    }
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
}
