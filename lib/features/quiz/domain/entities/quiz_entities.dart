class QuizEntity {
  const QuizEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.difficulty,
    required this.timePerQuestionSec,
  });

  final String id;
  final String title;
  final String subtitle;
  final String difficulty; // easy|medium|hard
  final int timePerQuestionSec;
}

class QuestionEntity {
  const QuestionEntity({
    required this.id,
    required this.orderIndex,
    required this.text,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });

  final String id;
  final int orderIndex;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? explanation;
}

class QuizSession {
  const QuizSession({required this.quiz, required this.questions});

  final QuizEntity quiz;
  final List<QuestionEntity> questions;
}
