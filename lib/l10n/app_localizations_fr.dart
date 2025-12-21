// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get login => 'Connexion';

  @override
  String get signUp => 'Inscription';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get enterUsername => 'Entrez votre nom d\'utilisateur';

  @override
  String get enterEmail => 'Entrez votre adresse e-mail';

  @override
  String get enterPassword => 'Entrez votre mot de passe';

  @override
  String get enterConfirmPassword => 'Confirmez votre mot de passe';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get continueWithApple => 'Continuer avec Apple';

  @override
  String get orContinueWith => 'Ou continuer avec';

  @override
  String get errorEmailRequired => 'L’adresse e-mail est requise';

  @override
  String get errorInvalidEmail => 'Adresse e-mail invalide';

  @override
  String get errorPasswordRequired => 'Le mot de passe est requis';

  @override
  String get errorPasswordLength => 'Au moins 6 caractères';

  @override
  String get errorUsernameRequired => 'Le nom d\'utilisateur est requis';

  @override
  String get errorUsernameLength => 'Au moins 3 caractères';

  @override
  String get errorConfirmPasswordRequired =>
      'Veuillez confirmer votre mot de passe';

  @override
  String get errorPasswordsDoNotMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get navHome => 'Accueil';

  @override
  String get navLeaderboard => 'Classement';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get homeTitle => 'Trouvez votre prochain quiz';

  @override
  String get homeSearchHint => 'Rechercher des catégories ou des thèmes…';

  @override
  String get homeFeaturedQuizzes => 'Quiz en vedette';

  @override
  String get homeExploreCategories => 'Explorer les catégories';

  @override
  String get homeStartQuiz => 'Commencer le quiz';

  @override
  String get homeNotif => 'Notifications';

  @override
  String get homeFeaturedQuiz1Title => 'Préparation Olympiades de Sciences';

  @override
  String get homeFeaturedQuiz1Subtitle =>
      'Révisez des concepts avancés et préparez le prochain niveau.';

  @override
  String get homeFeaturedQuiz2Title => 'Culture générale';

  @override
  String get homeFeaturedQuiz2Subtitle =>
      'Testez vos connaissances avec des questions rapides.';

  @override
  String get catLiterature => 'Littérature';

  @override
  String get catChemistry => 'Chimie';

  @override
  String get catGeography => 'Géographie';

  @override
  String get catPsychology => 'Psychologie';

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
      zero: '0 question',
    );
    return '$_temp0';
  }
}
