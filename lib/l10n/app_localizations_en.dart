// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get username => 'Username';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get enterUsername => 'Enter your username';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get enterConfirmPassword => 'Confirm your password';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get errorEmailRequired => 'Email is required';

  @override
  String get errorInvalidEmail => 'Invalid email address';

  @override
  String get errorPasswordRequired => 'Password is required';

  @override
  String get errorPasswordLength => 'At least 6 characters';

  @override
  String get errorUsernameRequired => 'Username is required';

  @override
  String get errorUsernameLength => 'At least 3 characters';

  @override
  String get errorConfirmPasswordRequired => 'Confirm your password';

  @override
  String get errorPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get navHome => 'Home';

  @override
  String get navLeaderboard => 'Leaderboard';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeTitle => 'Find Your Next Quiz';

  @override
  String get homeSearchHint => 'Search for categories or topics…';

  @override
  String get homeFeaturedQuizzes => 'Featured Quizzes';

  @override
  String get homeExploreCategories => 'Explore Categories';

  @override
  String get homeStartQuiz => 'Start Quiz';

  @override
  String get homeNotif => 'Notifications';

  @override
  String get homeFeaturedQuiz1Title => 'Science Olympiad Prep';

  @override
  String get homeFeaturedQuiz1Subtitle =>
      'Master advanced concepts and prepare for the next level.';

  @override
  String get homeFeaturedQuiz2Title => 'General Knowledge';

  @override
  String get homeFeaturedQuiz2Subtitle =>
      'Challenge yourself with quick questions.';

  @override
  String get catLiterature => 'Literature';

  @override
  String get catChemistry => 'Chemistry';

  @override
  String get catGeography => 'Geography';

  @override
  String get catPsychology => 'Psychology';

  @override
  String get catAcademia => 'Academia';

  @override
  String get catInnovations => 'Innovations';

  @override
  String homeQuestionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '1 question',
      zero: '0 questions',
    );
    return '$_temp0';
  }

  @override
  String quizQuestionProgress(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String quizTimeRemaining(Object seconds) {
    return 'Time remaining: ${seconds}s';
  }

  @override
  String get quizNextQuestion => 'Next Question';

  @override
  String get resultsTitle => 'Results';

  @override
  String get resultsYourScore => 'YOUR SCORE';

  @override
  String get resultsEncouragement => 'Excellent work! Keep it up!';

  @override
  String get resultsPerformanceOverview => 'Performance Overview';

  @override
  String get resultsCorrectAnswers => 'Correct Answers';

  @override
  String get resultsIncorrectAnswers => 'Incorrect Answers';

  @override
  String get resultsRetryQuiz => 'Retry Quiz';

  @override
  String get resultsShareResults => 'Share Results';

  @override
  String get resultsShareComingSoon => 'Sharing is coming soon.';

  @override
  String resultsScoreSlash(Object total) {
    return '/$total';
  }
}
