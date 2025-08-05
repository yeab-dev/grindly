import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/core/router/app_router.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:grindly/features/auth/presentation/cubits/signup/sign_up_cubit.dart';
import 'package:grindly/shared/data/repository/remote/user_remote_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(
            authRepository: getIt<AuthRepository>(),
            userRemoteRepository: getIt<UserRemoteRepository>(),
          ),
        ),
        BlocProvider(create: (context) => getIt<SignInCubit>()),
      ],
      child: MaterialApp.router(
        routerConfig: goRouter, // from app_router.dart
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3BBE44),
            primary: const Color(0xFF3BBE44),
          ),
          useMaterial3: true,
          textTheme: ThemeData.light().textTheme.copyWith(
            displaySmall: const TextStyle(
              color: Color(0xFF3BBE44),
              fontFamily: 'JacquesFrancois',
            ),
          ),
        ),
      ),
    );
  }
}
