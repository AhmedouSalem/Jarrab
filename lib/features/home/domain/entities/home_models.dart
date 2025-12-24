class HomeCategory {
  const HomeCategory({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.quizCount,
  });

  final String id;
  final String name;
  final String iconKey;
  final int quizCount;
}

class FeaturedQuiz {
  const FeaturedQuiz({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final String title;
  final String subtitle;
}
