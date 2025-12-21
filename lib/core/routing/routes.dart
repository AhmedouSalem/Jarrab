import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jarrab/core/routing/app_router.dart';
import 'package:jarrab/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:jarrab/features/profile/presentation/pages/profile_page.dart';
import 'package:jarrab/features/quiz/presentation/pages/quiz_page.dart';
import 'package:jarrab/features/quiz/presentation/pages/results_page.dart';
import 'package:jarrab/features/settings/presentation/pages/settings_page.dart';
import 'package:jarrab/core/ui/shared/pages/app_shell_page.dart';

import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_signup_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

/// À connecter plus tard à un stream FirebaseAuth via un bloc/cubit:
/// - si user connecté -> home
/// - sinon -> auth
class AuthSession extends ChangeNotifier {
  bool isAuthenticated = true;

  void setAuthenticated(bool value) {
    isAuthenticated = value;
    notifyListeners();
  }
}

GoRouter buildRouter(AuthSession session) {
  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: session, // permet redirect reactif
    redirect: (context, state) {
      final loc = state.uri.path;
      final authed = session.isAuthenticated;

      final isSplash = loc == Routes.splash;
      final isAuth = loc == Routes.auth;
      final isInApp = loc.startsWith(Routes.app);

      if (isSplash) return null;

      if (!authed && !isAuth) return Routes.auth;
      if (authed && (isAuth || loc == Routes.app)) return Routes.home;
      if (authed && !isInApp && !isSplash) return Routes.home;

      return null;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (_, __) => const SplashPage()),
      GoRoute(path: Routes.auth, builder: (_, __) => const LoginSignUpPage()),
      GoRoute(
        path: Routes.quiz,
        builder: (context, state) {
          final quizId = state.pathParameters['quizId']!;
          return AppShellPage(
            useHorizontalPadding: false,
            child: QuizPage(quizId: quizId),
          );
        },
      ),

      GoRoute(
        path: Routes.results,
        builder: (context, state) {
          final extra = state.extra;
          return ResultsPage(extra: extra);
        },
      ),
      // Shell (bottom nav)
      GoRoute(path: Routes.app, redirect: (_, __) => Routes.home),

      GoRoute(
        path: Routes.home,
        builder: (_, __) =>
            const AppShellPage(useHorizontalPadding: false, child: HomePage()),
      ),
      GoRoute(
        path: Routes.leaderboard,
        builder: (_, __) => const AppShellPage(
          useHorizontalPadding: false,
          child: LeaderboardPage(),
        ),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (_, __) => const AppShellPage(
          useHorizontalPadding: false,
          child: ProfilePage(),
        ),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (_, __) => const AppShellPage(
          useHorizontalPadding: false,
          child: SettingsPage(),
        ),
      ),
    ],
    errorBuilder: (_, state) =>
        Scaffold(body: Center(child: Text('Route error: ${state.error}'))),
  );
}
