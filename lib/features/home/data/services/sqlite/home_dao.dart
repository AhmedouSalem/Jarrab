import 'package:sqflite/sqflite.dart';

class HomeDao {
  HomeDao(this.db);
  final Database db;

  Future<List<Map<String, Object?>>> getActiveCategories() {
    return db.query(
      'categories',
      where: 'isActive = 1',
      orderBy: 'orderIndex ASC',
    );
  }

  Future<List<Map<String, Object?>>> getFeaturedPublicQuizzes() {
    return db.query(
      'quizzes',
      where: 'isFeatured = 1 AND isPublic = 1',
      orderBy: 'updatedAt DESC',
      limit: 20,
    );
  }
}
