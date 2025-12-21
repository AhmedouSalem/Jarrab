import 'package:flutter/material.dart';
import 'package:jarrab/features/auth/presentation/form/auth_form_state.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/features/auth/presentation/widgets/auth_background.dart';
import 'package:jarrab/shared/widgets/app_logo.dart';
import 'package:jarrab/features/auth/presentation/widgets/auth_tabs.dart';
import 'package:jarrab/features/auth/presentation/widgets/gradient_button.dart';
import 'package:jarrab/features/auth/presentation/widgets/labeled_field.dart';
import 'package:jarrab/features/auth/presentation/widgets/password_field.dart';
import 'package:jarrab/features/auth/presentation/widgets/social_auth_buttons.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  late final AuthFormState form = AuthFormState();

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    form.setL10n(AppLocalizations.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.pick<double>(
      context,
      compact: 420,
      medium: 520,
      expanded: 560,
    );

    final padding = Responsive.pick<EdgeInsets>(
      context,
      compact: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      medium: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      expanded: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
    );

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: AuthBackground(
        child: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),

                        const Center(child: AppLogo()),

                        const SizedBox(height: 22),

                        AuthTabs(
                          isLogin: form.isLogin,
                          onTapLogin: () => setState(() {
                            form.setModeLogin(true);
                            form.validateAll();
                            FocusScope.of(context).unfocus();
                          }),
                          onTapSignUp: () => setState(() {
                            form.setModeLogin(false);
                            form.validateAll();
                            FocusScope.of(context).unfocus();
                          }),
                        ),

                        const SizedBox(height: 18),

                        if (!form.isLogin) ...[
                          LabeledField(
                            label: l10n.username,
                            child: TextField(
                              controller: form.usernameCtrl,
                              textInputAction: TextInputAction.next,
                              onChanged: (_) => setState(() {
                                form.validateUsername();
                              }),
                              focusNode: form.usernameFocus,
                              onSubmitted: (_) =>
                                  form.emailFocus.requestFocus(),
                              decoration: _inputDecoration(
                                context,
                                hintText: l10n.enterUsername,
                                icon: Icons.person_outline_rounded,
                              ).copyWith(errorText: form.usernameError),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],

                        LabeledField(
                          label: l10n.emailAddress,
                          child: TextField(
                            controller: form.emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            focusNode: form.emailFocus,
                            onSubmitted: (_) =>
                                form.passwordFocus.requestFocus(),
                            onChanged: (_) => setState(() {
                              form.validateEmail();
                            }),
                            decoration: _inputDecoration(
                              context,
                              hintText: l10n.enterEmail,
                              icon: Icons.mail_outline_rounded,
                            ).copyWith(errorText: form.emailError),
                          ),
                        ),

                        const SizedBox(height: 14),

                        LabeledField(
                          label: l10n.password,
                          child: PasswordField(
                            controller: form.passwordCtrl,
                            focusNode: form.passwordFocus,
                            textInputAction: form.isLogin
                                ? TextInputAction.done
                                : TextInputAction.next,
                            onSubmitted: (_) {
                              if (form.isLogin) {
                                FocusScope.of(context).unfocus();
                              } else {
                                form.confirmPasswordFocus.requestFocus();
                              }
                            },
                            onChanged: (_) => setState(() {
                              form.validatePassword();
                              form.validateConfirmPassword();
                            }),
                            decoration: _inputDecoration(
                              context,
                              hintText: l10n.enterPassword,
                              icon: Icons.lock_outline_rounded,
                            ).copyWith(errorText: form.passwordError),
                          ),
                        ),

                        if (!form.isLogin) ...[
                          const SizedBox(height: 14),
                          LabeledField(
                            label: l10n.confirmPassword,
                            child: PasswordField(
                              controller: form.confirmPasswordCtrl,
                              focusNode: form.confirmPasswordFocus,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (_) => setState(() {
                                form.validateConfirmPassword();
                              }),
                              decoration: _inputDecoration(
                                context,
                                hintText: l10n.enterConfirmPassword,
                                icon: Icons.lock_outline_rounded,
                              ).copyWith(errorText: form.confirmPasswordError),
                            ),
                          ),
                        ],

                        const SizedBox(height: 18),

                        SizedBox(
                          height: 56,
                          child: GradientButton(
                            text: form.isLogin ? l10n.login : l10n.signUp,
                            onPressed: form.isValid
                                ? () {
                                    FocusScope.of(context).unfocus();
                                    setState(form.validateAll);
                                    // plus tard: dispatch BLoC event
                                  }
                                : null,
                          ),
                        ),

                        const SizedBox(height: 18),

                        const SocialAuthButtons(),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hintText,
    required IconData icon,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
          width: 1.2,
        ),
      ),
    );
  }
}
