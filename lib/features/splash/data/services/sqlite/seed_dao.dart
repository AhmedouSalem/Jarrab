import 'dart:convert';
import 'package:sqflite/sqflite.dart';

class SeedDao {
  SeedDao(this.db);
  final Database db;

  Future<void> upsertCategory({
    required String id,
    required String name,
    required String iconKey,
    required int orderIndex,
    required int quizCount,
    required bool isActive,
    required int updatedAtMs,
  }) async {
    await db.insert('categories', {
      'id': id,
      'name': name,
      'iconKey': iconKey,
      'imageUrl': null,
      'orderIndex': orderIndex,
      'quizCount': quizCount,
      'isActive': isActive ? 1 : 0,
      'updatedAt': updatedAtMs,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> upsertQuiz({
    required String id,
    required String categoryId,
    required String title,
    required String subtitle,
    required String difficulty,
    required int timePerQuestionSec,
    required int questionCount,
    required bool isFeatured,
    required bool isPublic,
    required int updatedAtMs,
  }) async {
    await db.insert('quizzes', {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'subtitle': subtitle,
      'difficulty': difficulty,
      'timePerQuestionSec': timePerQuestionSec,
      'questionCount': questionCount,
      'isFeatured': isFeatured ? 1 : 0,
      'isPublic': isPublic ? 1 : 0,
      'coverImageUrl': null,
      'updatedAt': updatedAtMs,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> upsertQuestion({
    required String id,
    required String quizId,
    required int orderIndex,
    required String text,
    required List<String> options,
    required int correctIndex,
    String? explanation,
    String? imageUrl,
    required int updatedAtMs,
  }) async {
    await db.insert('questions', {
      'id': id,
      'quizId': quizId,
      'orderIndex': orderIndex,
      'text': text,
      'optionsJson': jsonEncode(options),
      'correctIndex': correctIndex,
      'explanation': explanation,
      'imageUrl': imageUrl,
      'updatedAt': updatedAtMs,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> setSyncMeta(String key, int lastSyncedAtMs) async {
    await db.insert('sync_meta', {
      'key': key,
      'lastSyncedAt': lastSyncedAtMs,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int?> getLastSync(String key) async {
    final rows = await db.query(
      'sync_meta',
      columns: ['lastSyncedAt'],
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first['lastSyncedAt'] as int;
  }
}
