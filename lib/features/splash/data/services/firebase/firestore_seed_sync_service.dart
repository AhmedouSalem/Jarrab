import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import '../sqlite/seed_dao.dart';

class FirestoreSeedSyncService {
  FirestoreSeedSyncService(this._fs);
  final FirebaseFirestore _fs;

  /// Sync "light" : categories + featured quizzes + questions (inline map) des featured
  Future<void> syncLight(Database db, {bool force = false}) async {
    final dao = SeedDao(db);
    final now = DateTime.now().millisecondsSinceEpoch;

    final last = await dao.getLastSync('seed_light');
    debugPrint('SYNC LIGHT: force=$force');
    debugPrint('SYNC LIGHT: last=$last now=$now');
    if (!force &&
        last != null &&
        (now - last) < const Duration(hours: 6).inMilliseconds) {
      return;
    }

    debugPrint('SYNC LIGHT: start');
    // 1) categories
    final categoriesSnap = await _fs.collection('categories').get();
    debugPrint('SYNC LIGHT: categories=${categoriesSnap.size}');

    // 2) featured quizzes public
    final quizzesSnap = await _fs
        .collection('quizzes')
        .where('isPublic', isEqualTo: true)
        // .where('isFeatured', isEqualTo: true)
        .get();
    debugPrint('SYNC LIGHT: featured quizzes=${quizzesSnap.size}');

    await db.transaction((txn) async {
      // categories
      for (final doc in categoriesSnap.docs) {
        final data = doc.data();
        await txn.insert('categories', {
          'id': doc.id,
          'name': data['name'] ?? '',
          'iconKey': data['iconKey'] ?? '',
          'imageUrl': data['imageUrl'],
          'orderIndex': (data['order'] ?? 0) as int,
          'quizCount': (data['quizCount'] ?? 0) as int,
          'isActive': (data['isActive'] ?? true) ? 1 : 0,
          'updatedAt': now,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // quizzes + questions inline
      for (final doc in quizzesSnap.docs) {
        final data = doc.data();

        await txn.insert('quizzes', {
          'id': doc.id,
          'categoryId': data['categoryId'] ?? '',
          'title': data['title'] ?? '',
          'subtitle': data['subtitle'],
          'difficulty': data['difficulty'] ?? 'easy',
          'timePerQuestionSec': (data['timePerQuestionSec'] ?? 25) as int,
          'questionCount': (data['questionCount'] ?? 0) as int,
          'isFeatured': (data['isFeatured'] ?? false) ? 1 : 0,
          'isPublic': (data['isPublic'] ?? true) ? 1 : 0,
          'coverImageUrl': data['coverImageUrl'],
          'updatedAt': now,
        }, conflictAlgorithm: ConflictAlgorithm.replace);

        final questions = data['questions'];
        if (questions is Map<String, dynamic>) {
          for (final entry in questions.entries) {
            final qId = entry.key;
            final q = entry.value as Map<String, dynamic>;

            final optionsRaw = q['options'];
            final options = (optionsRaw is List)
                ? optionsRaw.map((e) => e.toString()).toList()
                : <String>[];

            await txn.insert('questions', {
              'id': '${doc.id}_$qId',
              'quizId': doc.id,
              'orderIndex': (q['order'] ?? 0) as int,
              'text': q['text'] ?? '',
              'optionsJson': jsonEncode(options),
              'correctIndex': (q['correctIndex'] ?? 0) as int,
              'explanation': q['explanation'],
              'imageUrl': q['imageUrl'],
              'updatedAt': now,
            }, conflictAlgorithm: ConflictAlgorithm.replace);
          }
        }
      }

      await txn.insert('sync_meta', {
        'key': 'seed_light',
        'lastSyncedAt': now,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });

    final c = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM categories'),
    );
    final q = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM quizzes'),
    );
    final qs = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM questions'),
    );
    debugPrint('SQLITE COUNTS: categories=$c quizzes=$q questions=$qs');
  }
}
