import '../entities/quiz_entities.dart';
import '../repositories/quiz_repository.dart';

class GetQuizSessionUseCase {
  GetQuizSessionUseCase(this._repo);
  final QuizRepository _repo;

  Future<QuizSession> call(String quizId) => _repo.loadSession(quizId);
}
