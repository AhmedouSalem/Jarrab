import 'package:flutter/material.dart';
import 'package:jarrab/core/utils/validators.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class AuthFormState {
  AuthFormState();

  AppLocalizations? _l10n;
  void setL10n(AppLocalizations l10n) => _l10n = l10n;

  // Controllers
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  // Focus
  final usernameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  // Errors
  String? emailError;
  String? passwordError;
  String? usernameError;
  String? confirmPasswordError;

  bool isLogin = true;

  bool get isValid {
    final emailOk = emailError == null && emailCtrl.text.trim().isNotEmpty;
    final passOk =
        passwordError == null && Validators.isNotEmpty(passwordCtrl.text);

    if (isLogin) return emailOk && passOk;

    final userOk =
        usernameError == null && Validators.isNotEmpty(usernameCtrl.text);
    final confirmOk =
        confirmPasswordError == null &&
        Validators.isNotEmpty(confirmPasswordCtrl.text);

    return userOk && emailOk && passOk && confirmOk;
  }

  void setModeLogin(bool login) {
    isLogin = login;
    validateAll();
  }

  void validateEmail() {
    final v = emailCtrl.text.trim();

    if (!Validators.isNotEmpty(v)) {
      emailError = _l10n!.errorEmailRequired;
      return;
    }

    if (!Validators.isEmail(v)) {
      emailError = _l10n!.errorInvalidEmail;
      return;
    }

    emailError = null;
  }

  void validatePassword() {
    final v = passwordCtrl.text;

    if (!Validators.isNotEmpty(v)) {
      passwordError = _l10n!.errorPasswordRequired;
      return;
    }

    if (!Validators.hasMinLength(v, 6)) {
      passwordError = _l10n!.errorPasswordLength;
      return;
    }

    passwordError = null;
  }

  void validateUsername() {
    if (isLogin) {
      usernameError = null;
      return;
    }

    final v = usernameCtrl.text.trim();

    if (!Validators.isNotEmpty(v)) {
      usernameError = _l10n!.errorUsernameRequired;
      return;
    }

    if (!Validators.hasMinLength(v, 3)) {
      usernameError = _l10n!.errorUsernameLength;
      return;
    }

    usernameError = null;
  }

  void validateConfirmPassword() {
    if (isLogin) {
      confirmPasswordError = null;
      return;
    }

    final v = confirmPasswordCtrl.text;

    if (!Validators.isNotEmpty(v)) {
      confirmPasswordError = _l10n!.errorConfirmPasswordRequired;
      return;
    }

    if (!Validators.equals(v, passwordCtrl.text)) {
      confirmPasswordError = _l10n!.errorPasswordsDoNotMatch;
      return;
    }

    confirmPasswordError = null;
  }

  void validateAll() {
    validateUsername();
    validateEmail();
    validatePassword();
    validateConfirmPassword();
  }

  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    usernameCtrl.dispose();
    confirmPasswordCtrl.dispose();

    usernameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }
}
