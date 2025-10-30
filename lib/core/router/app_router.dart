import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/auth/presentation/pages/email_verification_page.dart';
import 'package:grindly/features/auth/presentation/pages/login.dart';
import 'package:grindly/features/auth/presentation/pages/sign_up_page.dart';
import 'package:grindly/features/wakatime/summarries/presentation/pages/todays_summaries_page.dart';
import 'package:grindly/features/wakatime/wakatime_auth/presentation/pages/wakatime_auth_page.dart';
import 'package:grindly/shared/user_profile/presentation/pages/edit_profile_page.dart';
import 'package:grindly/shared/user_profile/presentation/pages/user_profile_page.dart';

Future<GoRouter> route({required FlutterSecureStorage secureStorage}) async {
  final bool isUserSignedIn = FirebaseAuth.instance.currentUser != null;
  if (!isUserSignedIn &&
      !await secureStorage.containsKey(key: 'access_token')) {
    return GoRouter(
      initialLocation: Routes.login,
      routes: [
        GoRoute(
          path: Routes.signUp,
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(path: Routes.login, builder: (context, state) => const Login()),
        GoRoute(
          path: Routes.verify,
          builder: (context, state) => const EmailVerificationPage(),
        ),
        GoRoute(
          path: Routes.wakatimeAuth,
          builder: (context, state) => WakatimeAuthPage(),
        ),
        GoRoute(
          path: Routes.todaysSummary,
          builder: (context, state) => TodaysSummariesPage(),
        ),
        GoRoute(
          path: Routes.profilePage,
          builder: (context, state) => UserProfilePage(),
        ),

        GoRoute(
          path: Routes.editProfilePage,
          builder: (context, state) => EditProfilePage(),
        ),
      ],
    );
  } else if (!await secureStorage.containsKey(key: 'access_token')) {
    return goRouter;
  }
  return GoRouter(
    initialLocation: Routes.editProfilePage,
    routes: [
      GoRoute(path: Routes.signUp, builder: (context, state) => const SignUp()),
      GoRoute(path: Routes.login, builder: (context, state) => const Login()),
      GoRoute(
        path: Routes.verify,
        builder: (context, state) => const EmailVerificationPage(),
      ),
      GoRoute(
        path: Routes.wakatimeAuth,
        builder: (context, state) => WakatimeAuthPage(),
      ),
      GoRoute(
        path: Routes.todaysSummary,
        builder: (context, state) => TodaysSummariesPage(),
      ),
      GoRoute(
        path: Routes.profilePage,
        builder: (context, state) => UserProfilePage(),
      ),
      GoRoute(
        path: Routes.editProfilePage,
        builder: (context, state) => EditProfilePage(),
      ),
    ],
  );
}

final goRouter = GoRouter(
  initialLocation: Routes.signUp,
  routes: [
    GoRoute(path: Routes.signUp, builder: (context, state) => const SignUp()),
    GoRoute(path: Routes.login, builder: (context, state) => const Login()),
    GoRoute(
      path: Routes.verify,
      builder: (context, state) => const EmailVerificationPage(),
    ),
    GoRoute(
      path: Routes.wakatimeAuth,
      builder: (context, state) => WakatimeAuthPage(),
    ),
    GoRoute(
      path: Routes.todaysSummary,
      builder: (context, state) => TodaysSummariesPage(),
    ),
    GoRoute(
      path: Routes.editProfilePage,
      builder: (context, state) => EditProfilePage(),
    ),
  ],
);
