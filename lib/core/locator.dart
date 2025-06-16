import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  //core dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //Repository
  getIt.registerLazySingleton(
    () => AuthRepository(firebaseAuth: getIt<FirebaseAuth>()),
  );
}
