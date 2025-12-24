import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';

class SyncUserOutboxUseCase {
  SyncUserOutboxUseCase({
    required this.db,
    required this.fs,
  });

  final Database db;
  final FirebaseFirestore fs;

  Future<void> call({
    required String uid,
    String? displayName,
    String? avatarUrl,
  }) async {
    // 1) attempts
    final attempts = await db.query(
      'attempts',
      where: 'uid = ? AND isSynced = 0',
      whereArgs: [uid],
      orderBy: 'completedAt ASC',
      limit: 200,
    );

    if (attempts.isNotEmpty) {
      final batch = fs.batch();
      final now = DateTime.now().toUtc();

      for (final a in attempts) {
        final attemptId = a['id'] as String;

        final ref = fs
            .collection('users')
            .doc(uid)
            .collection('attempts')
            .doc(attemptId);

        batch.set(ref, {
          'quizId': a['quizId'],
          'categoryId': a['categoryId'],
          'quizTitle': a['quizTitle'],
          'correctCount': a['correctCount'],
          'totalQuestions': a['totalQuestions'],
          'accuracy': a['accuracy'],
          'pointsEarned': a['pointsEarned'],
          'completedAt': Timestamp.fromMillisecondsSinceEpoch(a['completedAt'] as int),
          'uid': uid,
        }, SetOptions(merge: true));
      }

      await batch.commit();

      final nowMs = DateTime.now().millisecondsSinceEpoch;
      await db.transaction((txn) async {
        for (final a in attempts) {
          await txn.update(
            'attempts',
            {'isSynced': 1, 'syncedAt': nowMs},
            where: 'id = ?',
            whereArgs: [a['id']],
          );
        }
      });
    }

    // 2) stats/main
    final statsRows = await db.query('user_stats', where: 'uid=?', whereArgs: [uid], limit: 1);
    if (statsRows.isNotEmpty) {
      final s = statsRows.first;
      await fs.collection('users').doc(uid).collection('stats').doc('main').set({
        'streakDays': s['streakDays'],
        'totalQuestions': s['totalQuestions'],
        'totalCorrect': s['totalCorrect'],
        'quizzesTaken': s['quizzesTaken'],
        'accuracy': s['accuracy'],
        'xp': s['xp'],
        'level': s['level'],
        'xpToNextLevel': s['xpToNextLevel'],
        'lastPlayDate': s['lastPlayDate'] == null
            ? null
            : Timestamp.fromMillisecondsSinceEpoch(s['lastPlayDate'] as int),
        'updatedAt': Timestamp.now(),
      }, SetOptions(merge: true));
    }

    // 3) leaderboard all time (score = xp)
    final allTimeRows = await db.query('leaderboard_all_time', where: 'uid=?', whereArgs: [uid], limit: 1);
    if (allTimeRows.isNotEmpty) {
      final row = allTimeRows.first;
      await fs
          .collection('leaderboards_all_time')
          .doc('global')
          .collection('entries')
          .doc(uid)
          .set({
        'uid': uid,
        'displayName': row['displayName'] ?? displayName,
        'avatarUrl': row['avatarUrl'] ?? avatarUrl,
        'score': row['score'],
        'updatedAt': Timestamp.now(),
      }, SetOptions(merge: true));
    }

    // 4) leaderboard weekly (current weekKey)
    final weekKey = _weekKeyUtc(DateTime.now());
    final weeklyRows = await db.query(
      'leaderboard_weekly',
      where: 'weekKey=? AND uid=?',
      whereArgs: [weekKey, uid],
      limit: 1,
    );
    if (weeklyRows.isNotEmpty) {
      final row = weeklyRows.first;
      await fs
          .collection('leaderboards_weekly')
          .doc(weekKey)
          .collection('entries')
          .doc(uid)
          .set({
        'uid': uid,
        'displayName': row['displayName'] ?? displayName,
        'avatarUrl': row['avatarUrl'] ?? avatarUrl,
        'score': row['score'],
        'updatedAt': Timestamp.now(),
      }, SetOptions(merge: true));
    }
  }

  String _weekKeyUtc(DateTime dt) {
    final d = dt.toUtc();
    final w = _isoWeekNumber(d);
    return '${d.year}-W${w.toString().padLeft(2, '0')}';
  }

  int _isoWeekNumber(DateTime date) {
    final thursday = date.add(Duration(days: 3 - ((date.weekday + 6) % 7)));
    final firstThursday = DateTime(thursday.year, 1, 4);
    return 1 + (thursday.difference(firstThursday).inDays ~/ 7);
  }
}
