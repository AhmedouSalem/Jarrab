import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jarrab/core/routing/routes.dart';
import 'package:jarrab/features/quiz/presentation/pages/quiz_by_category_page.dart';

import 'package:jarrab/features/splash/presentation/pages/splash_page.dart';
import 'package:jarrab/features/auth/presentation/pages/login_signup_page.dart';
import 'package:jarrab/features/home/presentation/pages/home_page.dart';
import 'package:jarrab/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:jarrab/features/profile/presentation/pages/profile_page.dart';
import 'package:jarrab/features/settings/presentation/pages/settings_page.dart';
import 'package:jarrab/features/quiz/presentation/pages/quiz_page.dart';
import 'package:jarrab/features/quiz/presentation/pages/results_page.dart';
import 'package:jarrab/core/ui/shared/pages/app_shell_page.dart';

import '../../features/leaderboard/presentation/bloc/leaderboard_event.dart';
import '../di/injection.dart';

class AuthSession extends ChangeNotifier {
  bool _hasUser = false;
  bool _isAnonymous = true;

  bool get hasUser => _hasUser;
  bool get isAnonymous => _isAnonymous;

  bool get hasLinkedAccount => _hasUser && !_isAnonymous;

  void setAnonymousUser() {
    _hasUser = true;
    _isAnonymous = true;
    notifyListeners();
  }

  void setLinkedUser() {
    _hasUser = true;
    _isAnonymous = false;
    notifyListeners();
  }

  void clear() {
    _hasUser = false;
    _isAnonymous = true;
    notifyListeners();
  }
}

const _accountRequiredPrefixes = <String>[];

GoRouter buildRouter(AuthSession session) {
  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: session,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (loc == Routes.auth && session.hasLinkedAccount) {
        return Routes.home;
      }

      final needsAccount = _accountRequiredPrefixes.any(
        (p) => loc.startsWith(p),
      );

      if (needsAccount && !session.hasLinkedAccount) {
        return Routes.auth;
      }

      return null;
    },

    routes: [
      GoRoute(path: Routes.splash, builder: (_, __) => const SplashPage()),

      GoRoute(path: Routes.auth, builder: (_, __) => const LoginSignUpPage()),

      ShellRoute(
        builder: (context, state, child) {
          return AppShellPage(useHorizontalPadding: false, child: child);
        },
        routes: [
          GoRoute(path: Routes.home, builder: (_, __) => const HomePage()),
          GoRoute(
            path: Routes.leaderboard,
            builder: (_, __) => BlocProvider(create: (_) => Injection.I.createLeaderboardBloc()..add(const LeaderboardStarted()),
            child: const LeaderboardPage()),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (_, __) => const ProfilePage(),
          ),
          GoRoute(
            path: Routes.settings,
            builder: (_, __) => const SettingsPage(),
          ),
        ],
      ),

      GoRoute(
        path: Routes.quiz,
        builder: (context, state) {
          final quizId = state.pathParameters['quizId']!;
          return QuizPage(quizId: quizId);
        },
      ),
      GoRoute(
        path: Routes.quizByCategory,
        builder: (context, state) {
          final id = state.pathParameters['categoryId']!;
          return QuizByCategoryPage(categoryId: id);
        },
      ),

      GoRoute(
        path: Routes.results,
        builder: (context, state) => ResultsPage(extra: state.extra),
      ),
    ],

    errorBuilder: (_, state) =>
        Scaffold(body: Center(child: Text('Route error: ${state.error}'))),
  );
}
