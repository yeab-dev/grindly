import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:grindly/features/auth/presentation/cubits/signup/sign_up_cubit.dart';
import 'package:grindly/features/wakatime/summarries/data/repositories/wakatime_summaries_repository_impl.dart';
import 'package:grindly/features/wakatime/summarries/domain/repositories/wakatime_summarries_repository.dart';
import 'package:grindly/features/wakatime/summarries/presentation/cubit/wakatime_summaries_cubit.dart';
import 'package:grindly/features/wakatime/wakatime_auth/data/repositories/wakatime_auth_repository_impl.dart';
import 'package:grindly/features/wakatime/wakatime_auth/domain/repositories/wakatime_auth_repository.dart';
import 'package:grindly/features/wakatime/wakatime_auth/presentation/cubit/wakatime_auth_cubit.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/data/repositories/grindly_leaders_repository_impl.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/data/repositories/wakatime_leaders_repository_impl.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/repositories/grindly_leaders_repository.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/repositories/wakatime_leaders_repository.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/cubits/wakatime_leaders_cubit.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_all_time_since_today_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_basic_info_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_insight_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/data_sources/wakatime_stats_data_source.dart';
import 'package:grindly/features/wakatime/wakatime_profile/data/repositories/wakatime_profile_repository_impl.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/repositories/wakatime_profile_repository.dart';
import 'package:grindly/shared/data/repository/local/secure_storage_repository_impl.dart';
import 'package:grindly/shared/user_profile/data/repositories/user_repository_impl.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';
import 'package:grindly/shared/user_profile/domain/repositories/user_repository.dart';
import 'package:grindly/shared/user_profile/presentation/cubit/user_profile_cubit.dart';

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
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(firebaseAuth: getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
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

  getIt.registerLazySingleton<WakatimeSummariesRepository>(
    () => WakatimeSummariesRepositoryImpl(
      dio: getIt<Dio>(),
      storageRepository: getIt<SecureStorageRepository>(),
    ),
  );

  getIt.registerLazySingleton<WakatimeProfileRepository>(
    () => WakatimeProfileRepositoryImpl(
      allTimeSinceTodayDataSource: getIt<WakatimeAllTimeSinceTodayDataSource>(),
      insightDataSource: getIt<WakatimeInsightDataSource>(),
      basicInfoDataSource: getIt<WakatimeBasicInfoDataSource>(),
      statsDataSource: getIt<WakatimeStatsDataSource>(),
    ),
  );

  getIt.registerLazySingleton<WakatimeLeadersRepository>(
    () => WakatimeLeadersRepositoryImpl(
      dio: getIt<Dio>(),
      storageRepository: getIt<SecureStorageRepository>(),
    ),
  );

  getIt.registerLazySingleton<GrindlyLeadersRepository>(
    () => GrindlyLeadersRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
  );
  //data sources

  getIt.registerLazySingleton<WakatimeAllTimeSinceTodayDataSource>(
    () => WakatimeAllTimeSinceTodayDataSource(
      dio: getIt<Dio>(),
      repository: getIt<SecureStorageRepository>(),
    ),
  );

  getIt.registerLazySingleton<WakatimeInsightDataSource>(
    () => WakatimeInsightDataSource(
      dio: getIt<Dio>(),
      storageRepository: getIt<SecureStorageRepository>(),
    ),
  );

  getIt.registerLazySingleton<WakatimeBasicInfoDataSource>(
    () => WakatimeBasicInfoDataSource(
      dio: getIt<Dio>(),
      repository: getIt<SecureStorageRepository>(),
    ),
  );

  getIt.registerLazySingleton<WakatimeStatsDataSource>(
    () => WakatimeStatsDataSource(
      dio: getIt<Dio>(),
      repository: getIt<SecureStorageRepository>(),
    ),
  );
  //cubits
  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(
      authRepository: getIt<AuthRepository>(),
      userRemoteRepository: getIt<UserRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(
    () => SignInCubit(
      authRepository: getIt<AuthRepository>(),
      userRemoteRepository: getIt<UserRepository>(),
    ),
  );

  getIt.registerFactory<WakatimeAuthCubit>(
    () => WakatimeAuthCubit(
      repository: getIt<WakatimeAuthRepository>(),
      storageRepository: getIt<SecureStorageRepository>(),
    ),
  );

  getIt.registerFactory<WakatimeSummariesCubit>(
    () => WakatimeSummariesCubit(
      repository: getIt<WakatimeSummariesRepository>(),
    ),
  );
  getIt.registerFactory<UserProfileCubit>(
    () => UserProfileCubit(
      storageRepository: getIt<SecureStorageRepository>(),
      repository: getIt<UserRepository>(),
      wakatimeRepository: getIt<WakatimeProfileRepository>(),
    ),
  );

  getIt.registerFactory<WakatimeLeadersCubit>(
    () => WakatimeLeadersCubit(
      grindlyLeadersRepository: getIt<GrindlyLeadersRepository>(),
      repository: getIt<WakatimeLeadersRepository>(),
      storageRepository: getIt<SecureStorageRepository>(),
    ),
  );
}
