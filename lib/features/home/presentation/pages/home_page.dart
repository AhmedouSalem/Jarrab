import 'package:flutter/material.dart';
import 'package:jarrab/features/home/presentation/widgets/category_grid.dart';
import 'package:jarrab/features/home/presentation/widgets/featured_quiz_carousel.dart';
import 'package:jarrab/features/home/presentation/widgets/home_header.dart';
import 'package:jarrab/features/home/presentation/widgets/home_search_field.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final featured = <FeaturedQuizUI>[
      FeaturedQuizUI(
        title: l10n.homeFeaturedQuiz1Title,
        subtitle: l10n.homeFeaturedQuiz1Subtitle,
        imageAsset: null,
      ),
      FeaturedQuizUI(
        title: l10n.homeFeaturedQuiz2Title,
        subtitle: l10n.homeFeaturedQuiz2Subtitle,
        imageAsset: null,
      ),
    ];

    final categories = <CategoryUI>[
      CategoryUI(
        icon: Icons.menu_book_outlined,
        title: l10n.catLiterature,
        questionsCount: 120,
      ),
      CategoryUI(
        icon: Icons.science_outlined,
        title: l10n.catChemistry,
        questionsCount: 95,
      ),
      CategoryUI(
        icon: Icons.public_outlined,
        title: l10n.catGeography,
        questionsCount: 76,
      ),
      CategoryUI(
        icon: Icons.psychology_outlined,
        title: l10n.catPsychology,
        questionsCount: 60,
      ),
      CategoryUI(
        icon: Icons.inventory_outlined,
        title: l10n.catAcademia,
        questionsCount: 200,
      ),
      CategoryUI(
        icon: Icons.inventory_outlined,
        title: l10n.catAcademia,
        questionsCount: 70,
      ),
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 6,
              left: 12,
              right: 12,
            ),
            child: HomeHeader(
              title: l10n.homeTitle,
              onNotificationTap: () {
                // UI-only pour l’instant
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(l10n.homeNotif)));
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 18,
              left: 12,
              right: 12,
            ),
            child: HomeSearchField(
              hintText: l10n.homeSearchHint,
              onChanged: (_) {},
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
                // UI-only pour l’instant
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 18,
              bottom: 10,
              left: 12,
              right: 12,
            ),
            child: Text(
              l10n.homeExploreCategories,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        CategoryGrid(categories: categories),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}
