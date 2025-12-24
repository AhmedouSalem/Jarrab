import 'package:sqflite/sqflite.dart';
import '../../models/leaderboard_entry_model.dart';
import '../../../domain/entities/leaderboard_entry.dart';

class LeaderboardSqliteService {
  LeaderboardSqliteService(this._db);
  final Database _db;

  Future<void> upsertAllTime(List<LeaderboardEntryModel> entries) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    await _db.transaction((txn) async {
      for (final e in entries) {
        await txn.insert(
          'leaderboard_all_time',
          e.toSqlRowAllTime(nowMs),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> upsertWeekly(String weekKey, List<LeaderboardEntryModel> entries) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    await _db.transaction((txn) async {
      for (final e in entries) {
        await txn.insert(
          'leaderboard_weekly',
          e.toSqlRowWeekly(weekKey, nowMs),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<LeaderboardEntry>> getAllTime({int limit = 50}) async {
    final rows = await _db.query(
      'leaderboard_all_time',
      orderBy: 'score DESC',
      limit: limit,
    );

    return rows
        .map((r) => LeaderboardEntry(
      uid: r['uid'] as String,
      displayName: (r['displayName'] as String?) ?? 'User',
      avatarUrl: r['avatarUrl'] as String?,
      score: (r['score'] as int?) ?? 0,
    ))
        .toList();
  }

  Future<List<LeaderboardEntry>> getWeekly({required String weekKey, int limit = 50}) async {
    final rows = await _db.query(
      'leaderboard_weekly',
      where: 'weekKey = ?',
      whereArgs: [weekKey],
      orderBy: 'score DESC',
      limit: limit,
    );

    return rows
        .map((r) => LeaderboardEntry(
      uid: r['uid'] as String,
      displayName: (r['displayName'] as String?) ?? 'User',
      avatarUrl: r['avatarUrl'] as String?,
      score: (r['score'] as int?) ?? 0,
    ))
        .toList();
  }
}
