import 'dart:convert';
import 'package:sqflite/sqflite.dart';

class QuizDao {
  QuizDao(this.db);
  final Database db;

  Future<Map<String, Object?>?> getQuizById(String quizId) async {
    final rows = await db.query(
      'quizzes',
      where: 'id = ?',
      whereArgs: [quizId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first;
  }

  Future<List<Map<String, Object?>>> getQuestionsByQuizId(String quizId) async {
    return db.query(
      'questions',
      where: 'quizId = ?',
      whereArgs: [quizId],
      orderBy: 'orderIndex ASC',
    );
  }

  static List<String> decodeOptions(Object? raw) {
    if (raw == null) return const [];
    final s = raw.toString().trim();
    try {
      final decoded = jsonDecode(s);
      if (decoded is List) return decoded.map((e) => e.toString()).toList();
    } catch (_) {}

    if (s.startsWith('[') && s.endsWith(']')) {
      final inside = s.substring(1, s.length - 1);
      if (inside.trim().isEmpty) return const [];
      return inside.split(',').map((e) => e.trim()).toList();
    }
    return s.split(',').map((e) => e.trim()).toList();
  }
}
