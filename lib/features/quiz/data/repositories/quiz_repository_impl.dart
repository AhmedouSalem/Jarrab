import 'package:sqflite/sqflite.dart';
import '../../domain/entities/quiz_entities.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../services/sqlite/quiz_dao.dart';

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl(this._db) : _dao = QuizDao(_db);

  final Database _db;
  final QuizDao _dao;

  @override
  Future<QuizSession> loadSession(String quizId) async {
    final quizRow = await _dao.getQuizById(quizId);
    if (quizRow == null) {
      throw StateError('Quiz not found in SQLite: $quizId');
    }

    final quiz = QuizEntity(
      id: (quizRow['id'] as String?) ?? quizId,
      title: (quizRow['title'] as String?) ?? '',
      subtitle: (quizRow['subtitle'] as String?) ?? '',
      difficulty: (quizRow['difficulty'] as String?) ?? 'easy',
      timePerQuestionSec: (quizRow['timePerQuestionSec'] as int?) ?? 25,
    );

    final questionRows = await _dao.getQuestionsByQuizId(quizId);
    final questions = questionRows.map((r) {
      return QuestionEntity(
        id: (r['id'] as String?) ?? '',
        orderIndex: (r['orderIndex'] as int?) ?? 0,
        text: (r['text'] as String?) ?? '',
        options: QuizDao.decodeOptions(r['optionsJson']),
        correctIndex: (r['correctIndex'] as int?) ?? 0,
        explanation: r['explanation'] as String?,
      );
    }).toList();

    if (questions.isEmpty) {
      throw StateError('No questions in SQLite for quiz: $quizId');
    }

    return QuizSession(quiz: quiz, questions: questions);
  }
}
