import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:grindly/shared/data/repository/remote/user_remote_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Core
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Auth Feature
  getIt.registerLazySingleton(
    () => AuthRepository(firebaseAuth: getIt<FirebaseAuth>()),
  );
  getIt.registerFactory(
    () => SignInCubit(
      authRepository: getIt<AuthRepository>(),
      userRemoteRepository: getIt<UserRemoteRepository>(),
    ),
  );

  //User
  getIt.registerLazySingleton<UserRemoteRepository>(
    () => UserRemoteRepository(firestore: getIt<FirebaseFirestore>()),
  );
}
