import 'package:flutter/material.dart';
import 'featured_quiz_carousel.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class FeaturedQuizCard extends StatelessWidget {
  const FeaturedQuizCard({
    super.key,
    required this.quiz,
    required this.onStart,
  });

  final FeaturedQuizUI quiz;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.10),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background (image si dispo sinon placeholder)
            Positioned.fill(
              child: quiz.imageAsset != null
                  ? Image.asset(quiz.imageAsset!, fit: BoxFit.cover)
                  : Container(color: theme.colorScheme.surfaceVariant),
            ),

            // overlay léger
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.surface.withValues(alpha: 0.05),
                      theme.colorScheme.surface.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    quiz.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    quiz.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onStart,
                      child: Text(l10n.homeStartQuiz),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
