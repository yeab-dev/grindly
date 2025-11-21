import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/main_scaffold.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/auth/presentation/pages/email_verification_page.dart';
import 'package:grindly/features/auth/presentation/pages/login.dart';
import 'package:grindly/features/auth/presentation/pages/sign_up_page.dart';
import 'package:grindly/features/wakatime/summarries/presentation/pages/todays_summaries_page.dart';
import 'package:grindly/features/wakatime/wakatime_auth/presentation/pages/wakatime_auth_page.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/pages/leader_board_page.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart'
    as grindly;
import 'package:grindly/shared/user_profile/presentation/pages/edit_profile_page.dart';
import 'package:grindly/shared/user_profile/presentation/pages/leader_profile_page.dart';
import 'package:grindly/shared/user_profile/presentation/pages/user_profile_page.dart';

List<GoRoute> _appRoutes() {
  return [
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
      builder: (context, state) => MainScaffold(
        title: "summary",
        currentIndex: 0,
        child: TodaysSummariesPage(),
      ),
    ),
    GoRoute(
      path: Routes.profilePage,
      builder: (context, state) => MainScaffold(
        title: "profile",
        currentIndex: 1,
        child: UserProfilePage(),
      ),
    ),
    GoRoute(
      path: Routes.editProfilePage,
      builder: (context, state) => MainScaffold(
        child: EditProfilePage(user: state.extra as grindly.User),
      ),
    ),
    GoRoute(
      path: Routes.leaderboard,
      builder: (context, state) => MainScaffold(
        title: "leaderboard",
        currentIndex: 2,
        child: LeaderBoardPage(grindlyUser: state.extra as grindly.User),
      ),
    ),

    GoRoute(
      path: Routes.leaderProfilePage,
      builder: (context, state) => LeaderProfilePage(),
    ),
  ];
}

Future<GoRouter> route({required FlutterSecureStorage secureStorage}) async {
  final bool isUserSignedIn = FirebaseAuth.instance.currentUser != null;
  final hasToken = await secureStorage.containsKey(key: 'access_token');
  final initial = (!isUserSignedIn && !hasToken)
      ? Routes.login
      : Routes.profilePage;

  if (!isUserSignedIn && !hasToken) {
    return GoRouter(initialLocation: initial, routes: _appRoutes());
  } else if (!hasToken) {
    return goRouter;
  }

  return GoRouter(initialLocation: initial, routes: _appRoutes());
}

final goRouter = GoRouter(initialLocation: Routes.signUp, routes: _appRoutes());
