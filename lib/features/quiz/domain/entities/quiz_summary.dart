class QuizSummary {
  const QuizSummary({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.difficulty,
    required this.questionCount,
    required this.timePerQuestionSec,
    required this.isFeatured,
  });

  final String id;
  final String title;
  final String subtitle;
  final String difficulty; // easy|medium|hard
  final int questionCount;
  final int timePerQuestionSec;
  final bool isFeatured;
}
