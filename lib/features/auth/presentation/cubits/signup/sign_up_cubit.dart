import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:grindly/shared/data/repository/remote/user_remote_repository.dart';
import 'package:grindly/shared/domain/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/domain/models/auth_failure.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  final UserRemoteRepository userRemoteRepository;
  SignUpCubit({
    required this.authRepository,
    required this.userRemoteRepository,
  }) : super(SignUpState());

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    try {
      //Authenticate User
      final credential = await authRepository.signUpWithEmailAndPassword(
        email,
        password,
      );
      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        emit(
          state.copyWith(
            status: SignUpStatus.failure,
            failure: SignUpWithEmailAndPasswordFailure("Registration Failed"),
          ),
        );
        return;
      }

      await firebaseUser.updateDisplayName(displayName);
      await firebaseUser.reload();
      await authRepository.sendEmailVerification();
      emit(state.copyWith(status: SignUpStatus.success, user: credential.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(
          state.copyWith(
            status: SignUpStatus.failure,
            failure: SignInWithEmailAndPasswordFailure(
              "This email is already associated with another account. If you signed up with Google, please continue with Google.",
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SignUpStatus.failure,
            failure: SignUpWithEmailAndPasswordFailure.fromCode(e.code),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          failure: SignUpWithEmailAndPasswordFailure("Unexpected Error!"),
        ),
      );
    }
  }

  Future<bool> isVerifiedUser() async {
    await authRepository.getCurrentUser()!.reload();
    return (authRepository.getCurrentUser()!.emailVerified);
  }
}
