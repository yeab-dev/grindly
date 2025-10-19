import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/domain/models/auth_failure.dart';
import 'package:grindly/shared/user_profile/data/models/user_model.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  final UserRepository userRemoteRepository;
  SignInCubit({
    required this.authRepository,
    required this.userRemoteRepository,
  }) : super(SignInState());

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: SignInStatus.loading));
    try {
      final credential = await authRepository.signInWithEmailAndPassword(
        email,
        password,
      );
      if (credential.user != null && !credential.user!.emailVerified) {
        emit(
          state.copyWith(
            status: SignInStatus.failure,
            failure: SignInWithEmailAndPasswordFailure(
              'Email not verified. Please verify your email before signing in.',
            ),
          ),
        );
        return;
      }
      //Save user to cloud firestore
      await userRemoteRepository.saveUser(
        UserModel.fromFirebaseUser(credential.user!),
      );
      emit(state.copyWith(status: SignInStatus.success, user: credential.user));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: SignInStatus.failure,
          failure: SignInWithEmailAndPasswordFailure.fromCode(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInStatus.failure,
          failure: SignInWithEmailAndPasswordFailure(e.toString()),
        ),
      );
    }
  }

  Future<void> continueWithGoogle() async {
    emit(state.copyWith(status: SignInStatus.loading));
    try {
      final credential = await authRepository.continueWithGoogle();
      if (credential.user == null) {
        emit(
          state.copyWith(
            status: SignInStatus.failure,
            failure: SignInWithEmailAndPasswordFailure(
              'Google sign-in failed.',
            ),
          ),
        );
        return;
      }
      //Save user to cloud firestore
      await userRemoteRepository.saveUser(
        UserModel.fromFirebaseUser(credential.user!),
      );
      emit(state.copyWith(status: SignInStatus.success, user: credential.user));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: SignInStatus.failure,
          failure: SignInWithEmailAndPasswordFailure.fromCode(e.code),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInStatus.failure,
          failure: SignInWithEmailAndPasswordFailure(e.toString()),
        ),
      );
    }
  }
}
