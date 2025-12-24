class Routes {
  static const splash = '/';
  static const auth = '/auth';

  // Shell (bottom nav container)
  static const app = '/app';

  // Tabs
  static const home = '/app/home';
  static const leaderboard = '/app/leaderboard';
  static const profile = '/app/profile';
  static const settings = '/app/settings';

  // Flow quiz
  static const quiz = '/app/quiz/:quizId';
  static const quizByCategory = '/app/category/:categoryId';
  static const results = '/app/results';

  static String quizByCategoryPath(String categoryId) =>
      '/app/category/$categoryId';

  static String quizPath(String quizId) => '/app/quiz/$quizId';
}
