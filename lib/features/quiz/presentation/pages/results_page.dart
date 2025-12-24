import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jarrab/core/di/injection.dart';
import 'package:jarrab/core/routing/routes.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/features/quiz/data/models/quiz_result_extra.dart';
import 'package:jarrab/features/quiz/presentation/bloc/results/results_bloc.dart';
import 'package:jarrab/features/quiz/presentation/bloc/results/results_event.dart';
import 'package:jarrab/features/quiz/presentation/bloc/results/results_state.dart';
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
    QuizResultExtra? r;
    if (extra is QuizResultExtra) {
      r = extra as QuizResultExtra;
    } else if (extra is Map) {
      final data = extra as Map;
      final score = (data['correct'] as int?) ?? (data['score'] as int?) ?? 0;
      final total = (data['total'] as int?) ?? 0;
      r = QuizResultExtra(
        quizId: (data['quizId'] as String?) ?? '',
        quizTitle: (data['quizTitle'] as String?) ?? '',
        difficulty: (data['difficulty'] as String?) ?? 'easy',
        totalQuestions: total,
        correctCount: score,
        pointsEarned: (data['pointsEarned'] as int?) ?? 0,
        completedAtIso:
            (data['completedAtIso'] as String?) ??
            DateTime.now().toUtc().toIso8601String(),
      );
    }

    final score = r?.correctCount ?? 8;
    final total = r?.totalQuestions ?? 10;
    final correct = score;
    final incorrect = (total - score).clamp(0, 1 << 30);

    final quizId = r?.quizId;

    final maxWidth = Responsive.pick<double>(
      context,
      compact: 520,
      medium: 700,
      expanded: 720,
    );

    final hPad = Responsive.pick<double>(
      context,
      compact: 16,
      medium: 24,
      expanded: 32,
    );

    return BlocProvider(
      create: (_) => Injection.I.createResultsBloc()..add(ResultsStarted(r!)),
      child: BlocListener<ResultsBloc, ResultsState>(
        listenWhen: (_, s) => s is ResultsSaveError,
        listener: (context, state) {
          final err = state as ResultsSaveError;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Save failed: ${err.message}')),
          );
        },
        child: Scaffold(
          body: SafeArea(
            child: Material(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
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
                              context.go(Routes.home);
                            },
                            onShareTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.resultsShareComingSoon),
                                ),
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
                              if (quizId != null && quizId.isNotEmpty) {
                                context.pushReplacement(
                                  Routes.quizPath(quizId),
                                );
                                return;
                              }
                              context.go(Routes.home);
                            },
                            onShare: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.resultsShareComingSoon),
                                ),
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
          ),
        ),
      ),
    );
  }
}
