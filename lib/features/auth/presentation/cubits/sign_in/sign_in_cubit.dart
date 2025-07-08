import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/domain/models/auth_failure.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  SignInCubit({required this.authRepository}) : super(SignInState());

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
          failure: SignInWithEmailAndPasswordFailure(),
        ),
      );
    }
  }
}
