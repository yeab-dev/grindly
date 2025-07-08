import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:grindly/features/auth/presentation/cubits/signup/sign_up_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  //core
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //Auth
  getIt.registerLazySingleton(
    () => AuthRepository(firebaseAuth: getIt<FirebaseAuth>()),
  );

  getIt.registerFactory(
    () => SignInCubit(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory(
    () => SignUpCubit(authRepository: getIt<AuthRepository>()),
  );
}
