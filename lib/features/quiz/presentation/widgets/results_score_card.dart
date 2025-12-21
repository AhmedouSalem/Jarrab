import 'package:flutter/material.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class ResultsScoreCard extends StatelessWidget {
  const ResultsScoreCard({
    super.key,
    required this.score,
    required this.total,
    required this.headline,
    required this.message,
  });

  final int score;
  final int total;
  final String headline;
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: 0.85),
            scheme.secondary.withValues(alpha: 0.70),
          ],
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.emoji_events_outlined,
            color: Colors.white.withValues(alpha: 0.95),
            size: 34,
          ),
          const SizedBox(height: 10),
          Text(
            headline,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: theme.textTheme.displaySmall?.copyWith(
                color: Colors.white,
              ),
              children: [
                TextSpan(text: '$score'),
                TextSpan(
                  text: l10n.resultsScoreSlash(total),
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}
