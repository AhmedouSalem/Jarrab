sealed class QuizState {
  const QuizState();
}

final class QuizLoading extends QuizState {
  const QuizLoading();
}

final class QuizFailure extends QuizState {
  const QuizFailure(this.message);
  final String message;
}

final class QuizInProgress extends QuizState {
  const QuizInProgress({
    required this.quizId,
    required this.quizTitle,
    required this.difficulty,
    required this.currentIndex, // 0-based
    required this.total,
    required this.questionText,
    required this.options,
    required this.remainingSeconds,
    required this.selectedIndex,
    required this.correctCountSoFar,
  });

  final String quizId;
  final String quizTitle;
  final String difficulty;

  final int currentIndex;
  final int total;

  final String questionText;
  final List<String> options;

  final int remainingSeconds;
  final int selectedIndex;
  final int correctCountSoFar;

  double get progress => total == 0 ? 0 : (currentIndex + 1) / total;
}

final class QuizFinished extends QuizState {
  const QuizFinished(this.extra);
  final Object extra;
}
