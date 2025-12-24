import 'package:sqflite/sqflite.dart';

class QuizCatalogDao {
  QuizCatalogDao(this.db);
  final Database db;

  Future<Map<String, Object?>?> getCategoryById(String categoryId) async {
    final rows = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [categoryId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first;
  }

  Future<List<Map<String, Object?>>> getQuizzesByCategory(String categoryId) {
    return db.query(
      'quizzes',
      where: 'categoryId = ? AND isPublic = 1',
      whereArgs: [categoryId],
      orderBy: 'isFeatured DESC, title ASC',
    );
  }
}
