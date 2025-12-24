import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:jarrab/core/di/injection.dart';
import 'package:jarrab/core/routing/routes.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/features/home/presentation/bloc/home_bloc.dart';
import 'package:jarrab/features/home/presentation/bloc/home_event.dart';
import 'package:jarrab/features/home/presentation/bloc/home_state.dart';
import 'package:jarrab/features/home/presentation/widgets/category_grid.dart';
import 'package:jarrab/features/home/presentation/widgets/featured_quiz_carousel.dart';
import 'package:jarrab/features/home/presentation/widgets/home_header.dart';
import 'package:jarrab/features/home/presentation/widgets/home_search_field.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  IconData _iconFromKey(String key) {
    switch (key) {
      case 'book':
        return Icons.menu_book_outlined;
      case 'flask':
        return Icons.science_outlined;
      case 'globe':
        return Icons.public_outlined;
      case 'brain':
        return Icons.psychology_outlined;
      default:
        return Icons.inventory_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final horizontalPadding = Responsive.pick<double>(
      context,
      compact: 16,
      medium: 24,
      expanded: 32,
    );

    return BlocProvider(
      create: (_) => Injection.I.createHomeBloc()..add(const HomeStarted()),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return Center(child: Text('Home error: ${state.message}'));
            }

            final loaded = state as HomeLoaded;

            final featured = loaded.featured
                .map(
                  (q) => FeaturedQuizUI(
                    quizId: q.id,
                    title: q.title,
                    subtitle: q.subtitle,
                    imageAsset: null,
                  ),
                )
                .toList();

            final categories = loaded.categories
                .map(
                  (c) => CategoryUI(
                    id: c.id,
                    icon: _iconFromKey(c.iconKey),
                    title: c.name,
                    questionsCount: c.quizCount,
                  ),
                )
                .toList();

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(const HomeRefreshRequested());
                await Future.delayed(const Duration(milliseconds: 300));
              },
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 6,
                        left: horizontalPadding,
                        right: horizontalPadding,
                      ),
                      child: HomeHeader(
                        title: l10n.homeTitle,
                        onNotificationTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.homeNotif)),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 18,
                        left: horizontalPadding,
                        right: horizontalPadding,
                      ),
                      child: HomeSearchField(
                        hintText: l10n.homeSearchHint,
                        onChanged: (value) {
                          context.read<HomeBloc>().add(
                            HomeSearchChanged(value),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: FeaturedQuizCarousel(
                        title: l10n.homeFeaturedQuizzes,
                        items: featured,
                        onStartQuiz: (quiz) {
                          context.push(Routes.quizPath(quiz.quizId));
                        },
                        padding: horizontalPadding,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        bottom: 10,
                        left: horizontalPadding,
                        right: horizontalPadding,
                      ),
                      child: Text(
                        l10n.homeExploreCategories,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  CategoryGrid(
                    categories: categories,
                    padding: horizontalPadding,
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
