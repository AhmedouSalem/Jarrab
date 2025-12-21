// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get enterUsername => 'أدخل اسم المستخدم';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get enterConfirmPassword => 'أكد كلمة المرور';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get continueWithApple => 'المتابعة باستخدام Apple';

  @override
  String get orContinueWith => 'أو المتابعة باستخدام';

  @override
  String get errorEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get errorInvalidEmail => 'عنوان البريد الإلكتروني غير صالح';

  @override
  String get errorPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String get errorPasswordLength => 'يجب أن تحتوي على 6 أحرف على الأقل';

  @override
  String get errorUsernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get errorUsernameLength => 'يجب أن يحتوي على 3 أحرف على الأقل';

  @override
  String get errorConfirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get errorPasswordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navLeaderboard => 'الترتيب';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get navSettings => 'الاعدادات';

  @override
  String get homeTitle => 'اعثر على اختبارك التالي';

  @override
  String get homeSearchHint => 'ابحث عن الفئات أو المواضيع…';

  @override
  String get homeFeaturedQuizzes => 'اختبارات مميزة';

  @override
  String get homeExploreCategories => 'استكشف الفئات';

  @override
  String get homeStartQuiz => 'ابدأ الاختبار';

  @override
  String get homeNotif => 'الإشعارات';

  @override
  String get homeFeaturedQuiz1Title => 'التحضير لأولمبياد العلوم';

  @override
  String get homeFeaturedQuiz1Subtitle =>
      'تعلم مفاهيم متقدمة واستعد للمستوى التالي.';

  @override
  String get homeFeaturedQuiz2Title => 'معلومات عامة';

  @override
  String get homeFeaturedQuiz2Subtitle => 'اختبر معرفتك بأسئلة سريعة.';

  @override
  String get catLiterature => 'الأدب';

  @override
  String get catChemistry => 'الكيمياء';

  @override
  String get catGeography => 'الجغرافيا';

  @override
  String get catPsychology => 'علم النفس';

  @override
  String get catAcademia => 'أكاديميا';

  @override
  String get catInnovations => 'اختراع';

  @override
  String homeQuestionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سؤال',
      one: 'سؤال واحد',
      zero: '0 سؤال',
    );
    return '$_temp0';
  }

  @override
  String quizQuestionProgress(Object current, Object total) {
    return 'السؤال $current من $total';
  }

  @override
  String quizTimeRemaining(Object seconds) {
    return 'الوقت المتبقي: $secondsث';
  }

  @override
  String get quizNextQuestion => 'السؤال التالي';

  @override
  String get resultsTitle => 'النتائج';

  @override
  String get resultsYourScore => 'نتيجتك';

  @override
  String get resultsEncouragement => 'عمل رائع! استمر!';

  @override
  String get resultsPerformanceOverview => 'ملخص الأداء';

  @override
  String get resultsCorrectAnswers => 'إجابات صحيحة';

  @override
  String get resultsIncorrectAnswers => 'إجابات خاطئة';

  @override
  String get resultsRetryQuiz => 'أعد المحاولة';

  @override
  String get resultsShareResults => 'شارك النتائج';

  @override
  String get resultsShareComingSoon => 'ميزة المشاركة قريبًا.';

  @override
  String resultsScoreSlash(Object total) {
    return '/$total';
  }
}
