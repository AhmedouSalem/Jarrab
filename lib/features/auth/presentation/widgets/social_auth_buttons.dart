import 'package:flutter/material.dart';
import 'package:jarrab/features/auth/presentation/widgets/social_auth_button_item.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(height: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                l10n.orContinueWith,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: scheme.scrim),
              ),
            ),
            const Expanded(child: Divider(height: 1)),
          ],
        ),
        const SizedBox(height: 16),

        SocialAuthButtonItem(
          scheme: scheme,
          text: l10n.continueWithGoogle,
          onPressed: () {},
          icon: Icons.g_mobiledata_rounded,
        ),
        const SizedBox(height: 12),

        SocialAuthButtonItem(
          scheme: scheme,
          text: l10n.continueWithApple,
          onPressed: () {},
          icon: Icons.apple,
        ),
      ],
    );
  }
}
