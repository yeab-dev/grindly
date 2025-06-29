import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/core/locator.dart';
import 'package:grindly/features/auth/data/repository/auth_repository.dart';
import 'package:grindly/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:grindly/features/auth/presentation/pages/sign_up_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF3BBE44),
          primary: Color(0xFF3BBE44),
        ),
        useMaterial3: true,
        textTheme: ThemeData.light().textTheme.copyWith(
          displaySmall: TextStyle(
            color: Color(0xFF3BBE44),
            fontFamily: 'JacquesFrancois',
          ),
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    AuthCubit(authRepository: getIt<AuthRepository>()),
              ),
            ],
            child: SignUpPage(),
          ),
        ),
      ),
    );
  }
}
