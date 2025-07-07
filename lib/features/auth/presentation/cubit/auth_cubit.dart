import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/domain/models/auth_failure.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  void resetState() {
    emit(AuthInitial());
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(AuthRegistrationLoading());

    try {
      final UserCredential credintial = await authRepository
          .signUpWithEmailAndPassword(email, password);
      await credintial.user?.sendEmailVerification();
      emit(AuthRegistrationSuccess(credential: credintial));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(SignUpWithEmailAndPasswordFailure.withCode(e.code)));
    }
  }
}
