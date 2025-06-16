import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/presentation/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  //core
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //Auth
  getIt.registerLazySingleton(
    () => AuthRepository(firebaseAuth: getIt<FirebaseAuth>()),
  );

  getIt.registerFactory(
    () => AuthCubit(authRepository: getIt<AuthRepository>()),
  );
}
