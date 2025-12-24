import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:jarrab/core/di/injection.dart';
import 'package:jarrab/core/routing/routes.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:jarrab/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:jarrab/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_answer_tile.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_header.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_next_button.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_progress_bar.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_question_card.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.quizId});
  final String quizId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final gapS = Responsive.pick<double>(
      context,
      compact: 10,
      medium: 14,
      expanded: 16,
    );
    final gapM = Responsive.pick<double>(
      context,
      compact: 14,
      medium: 18,
      expanded: 20,
    );

    final horizontalPadding = Responsive.pick<double>(
      context,
      compact: 16,
      medium: 24,
      expanded: 32,
    );

    return BlocProvider(
      create: (_) => Injection.I.createQuizBloc()..add(QuizStarted(quizId)),
      child: BlocConsumer<QuizBloc, QuizState>(
        listenWhen: (_, next) => next is QuizFinished,
        listener: (context, state) {
          final done = state as QuizFinished;
          context.pushReplacement(Routes.results, extra: done.extra);
        },
        buildWhen: (_, next) => next is! QuizFinished,
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuizFailure) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Quiz error: ${state.message}'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () =>
                          context.read<QuizBloc>().add(QuizStarted(quizId)),
                      child: Text(l10n.resultsRetryQuiz),
                    ),
                  ],
                ),
              ),
            );
          }

          final s = state as QuizInProgress;
          final maxWidth = Responsive.pick<double>(
            context,
            compact: 520,
            medium: 640,
            expanded: 720,
          );

          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        maxWidth: maxWidth,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            QuizHeader(
                              title: l10n.quizQuestionProgress(
                                s.currentIndex + 1,
                                s.total,
                              ),
                              onBack: () => context.pop(),
                            ),
                            SizedBox(height: gapS),
                            QuizProgressBar(progress: s.progress),
                            SizedBox(height: gapM),
                            QuizQuestionCard(
                              questionIndex: s.currentIndex + 1,
                              totalQuestions: s.total,
                              question: s.questionText,
                              remainingSeconds: s.remainingSeconds,
                            ),
                            SizedBox(height: gapM),

                            ...List.generate(
                              s.options.length,
                              (i) => Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .shadow
                                          .withValues(alpha: 0.1),
                                      blurRadius: 14,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: QuizAnswerTile(
                                  index: i,
                                  label: s.options[i],
                                  selected: i == s.selectedIndex,
                                  onTap: () => context.read<QuizBloc>().add(
                                    AnswerSelected(i),
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            QuizNextButton(
                              enabled: s.selectedIndex != -1,
                              onPressed: () => context.read<QuizBloc>().add(
                                const NextPressed(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        //   ),
        // ),
      ),
    );
  }
}
