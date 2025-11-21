import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/core/router/app_router.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:grindly/features/auth/presentation/cubits/signup/sign_up_cubit.dart';
import 'package:grindly/features/wakatime/summarries/presentation/cubit/wakatime_summaries_cubit.dart';
import 'package:grindly/features/wakatime/wakatime_auth/presentation/cubit/wakatime_auth_cubit.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/cubits/wakatime_leaders_cubit.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/leader_profile/leader_profile_cubit.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/user_profile/user_profile_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignUpCubit>()),
        BlocProvider(create: (context) => getIt<SignInCubit>()),
        BlocProvider(create: (context) => getIt<WakatimeAuthCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<WakatimeSummariesCubit>()..getTodaysSummary(),
        ),
        BlocProvider(create: (context) => getIt<UserProfileCubit>()..getUser()),
        BlocProvider(
          create: (context) =>
              getIt<WakatimeLeadersCubit>()..getGlobalLeaders(),
        ),
        BlocProvider(create: (context) => getIt<LeaderProfileCubit>()),
      ],
      child: FutureBuilder<Object>(
        future: route(secureStorage: getIt<FlutterSecureStorage>()),
        builder: (context, snapshot) {
          /// 🌞 LIGHT THEME
          final lightTheme = ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              color: Color(0xFFEFFFF0),
              iconTheme: IconThemeData(color: Color(0xFF033206)),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3BBE44),
              primary: const Color(0xFF3BBE44),
              brightness: Brightness.light,
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Color(0xFF033206)),
              headlineSmall: const TextStyle(color: Color(0xFF033206)),
              displaySmall: const TextStyle(
                color: Color(0xFF3BBE44),
                fontFamily: 'JacquesFrancois',
              ),
            ),
          );

          /// While loading routes
          if (snapshot.connectionState != ConnectionState.done) {
            return MaterialApp(
              home: const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
              theme: lightTheme,
              themeMode: ThemeMode.system,
            );
          }

          /// When done
          return MaterialApp.router(
            routerConfig: snapshot.data as dynamic,
            theme: lightTheme,
            themeMode: ThemeMode.light,
          );
        },
      ),
    );
  }
}
