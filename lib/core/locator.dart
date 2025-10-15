import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:grindly/features/wakatime/wakatime-auth/data/repositories/wakatime_auth_repository_impl.dart';
import 'package:grindly/features/wakatime/wakatime-auth/domain/repositories/wakatime_auth_repository.dart';
import 'package:grindly/features/wakatime/wakatime-auth/presentation/cubit/wakatime_auth_cubit.dart';
import 'package:grindly/shared/data/repository/local/secure_storage_repository_impl.dart';
import 'package:grindly/shared/data/repository/remote/user_remote_repository.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Core
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );

  // repositories
  getIt.registerLazySingleton(
    () => AuthRepository(firebaseAuth: getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<UserRemoteRepository>(
    () => UserRemoteRepository(firestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<WakatimeAuthRepository>(
    () => WakatimeAuthRepositoryImpl(
      dio: getIt<Dio>(),
      clientId: dotenv.env['clientID']!,
      clientSecret: dotenv.env['clientSecret']!,
      redirectUri: dotenv.env['redirectURI']!,
    ),
  );

  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepositoryImpl(
      secureStorage: getIt<FlutterSecureStorage>(),
    ),
  );

  //cubits
  getIt.registerFactory(
    () => SignInCubit(
      authRepository: getIt<AuthRepository>(),
      userRemoteRepository: getIt<UserRemoteRepository>(),
    ),
  );

  getIt.registerFactory<WakatimeAuthCubit>(
    () => WakatimeAuthCubit(
      repository: getIt<WakatimeAuthRepository>(),
      storageRepository: getIt<SecureStorageRepository>(),
    ),
  );
}
