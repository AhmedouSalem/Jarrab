import 'package:flutter/material.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class QuizNextButton extends StatelessWidget {
  const QuizNextButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        child: Text(l10n.quizNextQuestion),
      ),
    );
  }
}
