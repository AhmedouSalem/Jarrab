class QuizResultExtra {
  const QuizResultExtra({
    required this.quizId,
    required this.quizTitle,
    required this.difficulty,
    required this.totalQuestions,
    required this.correctCount,
    required this.pointsEarned,
    required this.completedAtIso,
  });

  final String quizId;
  final String quizTitle;
  final String difficulty;
  final int totalQuestions;
  final int correctCount;
  final int pointsEarned;
  final String completedAtIso;
}
