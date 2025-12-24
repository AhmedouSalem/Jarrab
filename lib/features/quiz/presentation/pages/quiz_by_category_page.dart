import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:jarrab/core/di/injection.dart';
import 'package:jarrab/core/routing/routes.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/features/quiz/domain/entities/quiz_summary.dart';
import 'package:jarrab/features/quiz/presentation/bloc/category_quizzes/category_quizzes_bloc.dart';
import 'package:jarrab/features/quiz/presentation/bloc/category_quizzes/category_quizzes_event.dart';
import 'package:jarrab/features/quiz/presentation/bloc/category_quizzes/category_quizzes_state.dart';

class QuizByCategoryPage extends StatelessWidget {
  const QuizByCategoryPage({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.pick<double>(
      context,
      compact: 16,
      medium: 24,
      expanded: 32,
    );
    final maxWidth = Responsive.pick<double>(
      context,
      compact: 520,
      medium: 640,
      expanded: 720,
    );

    return BlocProvider(
      create: (_) =>
          Injection.I.createCategoryQuizzesBloc()
            ..add(CategoryQuizzesStarted(categoryId)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          title: BlocBuilder<CategoryQuizzesBloc, CategoryQuizzesState>(
            builder: (context, state) {
              if (state is CategoryQuizzesLoaded) {
                return Text(state.data.categoryName);
              }
              return const Text('Category');
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: BlocBuilder<CategoryQuizzesBloc, CategoryQuizzesState>(
                  builder: (context, state) {
                    if (state is CategoryQuizzesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CategoryQuizzesError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }

                    final data = (state as CategoryQuizzesLoaded).data;

                    if (data.quizzes.isEmpty) {
                      return const Center(
                        child: Text('No quizzes in this category.'),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      itemCount: data.quizzes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final q = data.quizzes[i];
                        return _QuizTile(
                          quiz: q,
                          onTap: () => context.push(Routes.quizPath(q.id)),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizTile extends StatelessWidget {
  const _QuizTile({required this.quiz, required this.onTap});
  final QuizSummary quiz;
  final VoidCallback onTap;

  String get _difficultyLabel {
    switch (quiz.difficulty) {
      case 'hard':
        return 'Hard';
      case 'medium':
        return 'Medium';
      default:
        return 'Easy';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Material(
      elevation: 10,
      shadowColor: cs.shadow.withValues(alpha: 0.30),
      color: cs.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  quiz.isFeatured
                      ? Icons.local_fire_department_rounded
                      : Icons.quiz_rounded,
                  color: cs.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      quiz.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Chip(
                          text: '$_difficultyLabel',
                          bg: cs.secondaryContainer,
                          fg: cs.onSecondaryContainer,
                        ),
                        _Chip(
                          text: '${quiz.questionCount} Q',
                          bg: cs.tertiaryContainer,
                          fg: cs.onTertiaryContainer,
                        ),
                        _Chip(
                          text: '${quiz.timePerQuestionSec}s',
                          bg: cs.surfaceContainerHighest,
                          fg: cs.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.bg, required this.fg});
  final String text;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
