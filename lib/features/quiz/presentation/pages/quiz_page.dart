import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jarrab/core/routing/app_router.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_header.dart';
import 'package:jarrab/l10n/app_localizations.dart';

import 'package:jarrab/features/quiz/presentation/widgets/quiz_progress_bar.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_question_card.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_answer_tile.dart';
import 'package:jarrab/features/quiz/presentation/widgets/quiz_next_button.dart';

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

    // 🔹 MOCK UI-ONLY
    const current = 1;
    const total = 5;
    const remainingSeconds = 28;
    const selectedIndex = 2;

    final answers = ['Berlin', 'Madrid', 'Paris', 'Rome'];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuizHeader(
                    title: l10n.quizQuestionProgress(current, total),
                    onBack: () => context.pop(),
                  ),

                  SizedBox(height: gapS),

                  QuizProgressBar(progress: current / total),

                  SizedBox(height: gapM),

                  QuizQuestionCard(
                    questionIndex: current,
                    totalQuestions: total,
                    question:
                        'What is the capital of France, a city renowned for its art, culture, and iconic landmarks such as the Eiffel Tower and the Louvre Museum?',
                    remainingSeconds: remainingSeconds,
                  ),

                  SizedBox(height: gapM),

                  ...List.generate(
                    answers.length,
                    (i) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.shadow.withValues(alpha: 0.1),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: QuizAnswerTile(
                        index: i,
                        label: answers[i],
                        selected: i == selectedIndex,
                        onTap: () {},
                      ),
                    ),
                  ),

                  const Spacer(),

                  QuizNextButton(
                    enabled: selectedIndex != -1,
                    onPressed: () {
                      context.pushReplacement(Routes.results, extra: {});
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
