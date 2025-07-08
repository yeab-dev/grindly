import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/auth/presentation/home_page.dart';
import 'package:grindly/features/auth/presentation/pages/login.dart';
import 'package:grindly/features/auth/presentation/pages/sign_up_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(path: Routes.signUp, builder: (context, state) => const SignUp()),
    GoRoute(path: Routes.login, builder: (context, state) => const Login()),
    GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
  ],
);
