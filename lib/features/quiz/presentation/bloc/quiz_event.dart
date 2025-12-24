sealed class QuizEvent {
  const QuizEvent();
}

final class QuizStarted extends QuizEvent {
  const QuizStarted(this.quizId);
  final String quizId;
}

final class AnswerSelected extends QuizEvent {
  const AnswerSelected(this.index);
  final int index;
}

final class NextPressed extends QuizEvent {
  const NextPressed();
}

final class Tick extends QuizEvent {
  const Tick();
}
