import 'package:firebase_auth/firebase_auth.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';

class SignUp {
  final AuthRepository authRepo;
  const SignUp({required this.authRepo});

  Future<UserCredential> call(String email, String password) async {
    return await authRepo.signUpWithEmailAndPassword(email, password);
  }
}
