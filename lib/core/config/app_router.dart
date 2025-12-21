class Routes {
  static const splash = '/';
  static const auth = '/auth';

  static const quiz = '/quiz/:quizId';
  static const results = '/results';

  // Shell
  static const app = '/app';

  // Tabs
  static const home = '/app/home';
  static const leaderboard = '/app/leaderboard';
  static const profile = '/app/profile';
  static const settings = '/app/settings';

  static String quizPath(String quizId) => '/quiz/$quizId';
}
