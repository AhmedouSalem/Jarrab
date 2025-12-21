import 'package:flutter/material.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/l10n/app_localizations.dart';

import '../widgets/results_actions.dart';
import '../widgets/results_app_bar.dart';
import '../widgets/results_performance_card.dart';
import '../widgets/results_score_card.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key, this.extra});
  final Object? extra;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // UI-only: on lit éventuellement extra si tu passes un Map plus tard.
    // Exemple attendu: {"score": 8, "total": 10, "correct": 8, "incorrect": 2}
    final data = (extra is Map) ? (extra as Map) : const {};
    final score = (data['score'] as int?) ?? 8;
    final total = (data['total'] as int?) ?? 10;
    final correct = (data['correct'] as int?) ?? 8;
    final incorrect = (data['incorrect'] as int?) ?? 2;

    final maxWidth = Responsive.pick<double>(
      context,
      compact: 520,
      medium: 640,
      expanded: 720,
    );

    final hPad = Responsive.pick<double>(
      context,
      compact: 16,
      medium: 24,
      expanded: 32,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: ResultsAppBar(
                      title: l10n.resultsTitle,
                      onHomeTap: () {
                        // Choix UX: retourner à Home (à adapter à tes routes)
                        Navigator.of(context).pop();
                      },
                      onShareTap: () {
                        // UI-only pour l’instant
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.resultsShareComingSoon)),
                        );
                      },
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 18)),

                  SliverToBoxAdapter(
                    child: ResultsScoreCard(
                      score: score,
                      total: total,
                      headline: l10n.resultsYourScore,
                      message: l10n.resultsEncouragement,
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  SliverToBoxAdapter(
                    child: ResultsPerformanceCard(
                      title: l10n.resultsPerformanceOverview,
                      correctLabel: l10n.resultsCorrectAnswers,
                      incorrectLabel: l10n.resultsIncorrectAnswers,
                      correct: correct,
                      incorrect: incorrect,
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 18)),

                  SliverToBoxAdapter(
                    child: ResultsActions(
                      primaryText: l10n.resultsRetryQuiz,
                      secondaryText: l10n.resultsShareResults,
                      onRetry: () {
                        // UI-only: tu peux pop jusqu’au quiz ou relancer plus tard via bloc
                        Navigator.of(context).pop();
                      },
                      onShare: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.resultsShareComingSoon)),
                        );
                      },
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
