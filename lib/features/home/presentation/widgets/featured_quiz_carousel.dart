import 'package:flutter/material.dart';
import 'featured_quiz_card.dart';

class FeaturedQuizUI {
  const FeaturedQuizUI({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });

  final String title;
  final String subtitle;
  final String? imageAsset;
}

class FeaturedQuizCarousel extends StatelessWidget {
  const FeaturedQuizCarousel({
    super.key,
    required this.title,
    required this.items,
    required this.onStartQuiz,
  });

  final String title;
  final List<FeaturedQuizUI> items;
  final ValueChanged<FeaturedQuizUI> onStartQuiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 190,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final quiz = items[index];
              return FeaturedQuizCard(
                quiz: quiz,
                onStart: () => onStartQuiz(quiz),
              );
            },
          ),
        ),
      ],
    );
  }
}
