import '../entities/quiz_entities.dart';

abstract class QuizRepository {
  Future<QuizSession> loadSession(String quizId);
}
