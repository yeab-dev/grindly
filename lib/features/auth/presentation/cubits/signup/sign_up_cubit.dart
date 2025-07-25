import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/domain/models/auth_failure.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit({required this.authRepository}) : super(SignUpState());

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    try {
      final credential = await authRepository.signUpWithEmailAndPassword(
        email,
        password,
      );
      await authRepository.sendEmailVerification();
      emit(state.copyWith(status: SignUpStatus.success, user: credential.user));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          failure: SignUpWithEmailAndPasswordFailure.fromCode(e.code),
        ),
      );
    }
  }
}
