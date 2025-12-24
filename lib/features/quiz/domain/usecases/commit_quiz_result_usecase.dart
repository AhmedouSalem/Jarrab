import 'package:jarrab/features/quiz/data/models/quiz_result_extra.dart';
import 'package:sqflite/sqflite.dart';

class CommitQuizResultUseCase {
  CommitQuizResultUseCase(this.db);
  final Database db;

  Future<void> call({
    required String uid,
    required QuizResultExtra result,
    required String? displayName,
    required String? avatarUrl,
  }) async {
    final now = DateTime.now();
    final nowMs = now.millisecondsSinceEpoch;

    final attemptId = 'att_${result.quizId}_$nowMs';

    await db.transaction((txn) async {
      // 1) insert attempt
      final accuracy = result.totalQuestions == 0
          ? 0.0
          : result.correctCount / result.totalQuestions;

      await txn.insert('attempts', {
        'id': attemptId,
        'uid': uid,
        'quizId': result.quizId,
        'categoryId': null,
        'quizTitle': result.quizTitle,
        'correctCount': result.correctCount,
        'totalQuestions': result.totalQuestions,
        'accuracy': accuracy,
        'pointsEarned': result.pointsEarned,
        'completedAt': nowMs,
        'isSynced': 0,
        'syncedAt': null,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      // 2) upsert user_stats
      final statsRows = await txn.query(
        'user_stats',
        where: 'uid = ?',
        whereArgs: [uid],
        limit: 1,
      );

      final prev = statsRows.isEmpty ? null : statsRows.first;

      final prevXp = (prev?['xp'] as int?) ?? 0;
      final prevTotalQ = (prev?['totalQuestions'] as int?) ?? 0;
      final prevTotalC = (prev?['totalCorrect'] as int?) ?? 0;
      final prevTaken = (prev?['quizzesTaken'] as int?) ?? 0;
      final prevStreak = (prev?['streakDays'] as int?) ?? 0;

      final lastPlayMs = prev?['lastPlayDate'] as int?;
      final newStreak = _computeStreak(prevStreak, lastPlayMs, nowMs);

      final newXp = prevXp + result.pointsEarned;
      final newTotalQ = prevTotalQ + result.totalQuestions;
      final newTotalC = prevTotalC + result.correctCount;
      final newTaken = prevTaken + 1;
      final newAccuracy = newTotalQ == 0 ? 0.0 : (newTotalC / newTotalQ);

      // Level (simple, tu pourras améliorer)
      final level = _levelFromXp(newXp);
      final xpToNext = _xpToNext(level);

      await txn.insert('user_stats', {
        'uid': uid,
        'streakDays': newStreak,
        'totalQuestions': newTotalQ,
        'totalCorrect': newTotalC,
        'quizzesTaken': newTaken,
        'accuracy': newAccuracy,
        'xp': newXp,
        'level': level,
        'xpToNextLevel': xpToNext,
        'lastPlayDate': nowMs,
        'updatedAt': nowMs,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      // 3) leaderboard all-time = xp (points cumulés)
      await txn.insert('leaderboard_all_time', {
        'uid': uid,
        'displayName': displayName,
        'avatarUrl': avatarUrl,
        'score': newXp,
        'updatedAt': nowMs,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      // 4) leaderboard weekly
      final weekKey = _weekKeyUtc(now);
      final weeklyRows = await txn.query(
        'leaderboard_weekly',
        where: 'weekKey = ? AND uid = ?',
        whereArgs: [weekKey, uid],
        limit: 1,
      );
      final prevWeekly = weeklyRows.isEmpty
          ? 0
          : (weeklyRows.first['score'] as int?) ?? 0;

      await txn.insert('leaderboard_weekly', {
        'weekKey': weekKey,
        'uid': uid,
        'displayName': displayName,
        'avatarUrl': avatarUrl,
        'score': prevWeekly + result.pointsEarned,
        'updatedAt': nowMs,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  int _computeStreak(int prevStreak, int? lastPlayMs, int nowMs) {
    if (lastPlayMs == null) return 1;

    final last = DateTime.fromMillisecondsSinceEpoch(lastPlayMs).toLocal();
    final now = DateTime.fromMillisecondsSinceEpoch(nowMs).toLocal();

    final lastDay = DateTime(last.year, last.month, last.day);
    final nowDay = DateTime(now.year, now.month, now.day);

    final diffDays = nowDay.difference(lastDay).inDays;

    if (diffDays == 0) return prevStreak; // déjà joué aujourd’hui
    if (diffDays == 1) return prevStreak + 1; // continuité
    return 1;
  }

  int _levelFromXp(int xp) {
    if (xp < 1000) return 1;
    if (xp < 2500) return 2;
    if (xp < 4500) return 3;
    if (xp < 7000) return 4;
    return 5 + ((xp - 7000) ~/ 3000);
  }

  int _xpToNext(int level) {
    return 8000 + (level - 1) * 2000;
  }

  String _weekKeyUtc(DateTime dt) {
    final d = dt.toUtc();
    final w = _isoWeekNumber(d);
    final ww = w.toString().padLeft(2, '0');
    return '${d.year}-W$ww';
  }

  int _isoWeekNumber(DateTime date) {
    final thursday = date.add(Duration(days: 3 - ((date.weekday + 6) % 7)));
    final firstThursday = DateTime(thursday.year, 1, 4);
    final diff = thursday.difference(firstThursday);
    return 1 + (diff.inDays ~/ 7);
  }
}
