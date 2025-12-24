import 'package:sqflite/sqflite.dart';

import '../../domain/entities/quiz_summary.dart';
import '../../domain/repositories/quiz_catalog_repository.dart';
import '../services/sqlite/quiz_catalog_dao.dart';

class QuizCatalogRepositoryImpl implements QuizCatalogRepository {
  QuizCatalogRepositoryImpl(this._db) : _dao = QuizCatalogDao(_db);

  final Database _db;
  final QuizCatalogDao _dao;

  @override
  Future<CategoryWithQuizzes> loadQuizzesByCategory(String categoryId) async {
    final cat = await _dao.getCategoryById(categoryId);
    final name = (cat?['name'] as String?) ?? categoryId;

    final rows = await _dao.getQuizzesByCategory(categoryId);

    final quizzes = rows.map((r) {
      return QuizSummary(
        id: (r['id'] as String?) ?? '',
        title: (r['title'] as String?) ?? '',
        subtitle: (r['subtitle'] as String?) ?? '',
        difficulty: (r['difficulty'] as String?) ?? 'easy',
        questionCount: (r['questionCount'] as int?) ?? 0,
        timePerQuestionSec: (r['timePerQuestionSec'] as int?) ?? 25,
        isFeatured: ((r['isFeatured'] as int?) ?? 0) == 1,
      );
    }).toList();

    return CategoryWithQuizzes(
      categoryId: categoryId,
      categoryName: name,
      quizzes: quizzes,
    );
  }
}
