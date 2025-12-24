import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/repositories/leaderboard_repository.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../services/firebase/leaderboard_firestore_service.dart';
import '../services/sqlite/leaderboard_sqlite_service.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  LeaderboardRepositoryImpl({
    required Database db,
    required FirebaseFirestore fs,
  })  : _sqlite = LeaderboardSqliteService(db),
        _remote = LeaderboardFirestoreService(fs);

  final LeaderboardSqliteService _sqlite;
  final LeaderboardFirestoreService _remote;

  @override
  Future<List<LeaderboardEntry>> loadAllTimeLocal({int limit = 50}) {
    return _sqlite.getAllTime(limit: limit);
  }

  @override
  Future<List<LeaderboardEntry>> loadWeeklyLocal({required String weekKey, int limit = 50}) {
    return _sqlite.getWeekly(weekKey: weekKey, limit: limit);
  }

  @override
  Future<void> syncAllTimeRemote({int limit = 50}) async {
    final remote = await _remote.fetchAllTimeTop(limit: limit);
    await _sqlite.upsertAllTime(remote);
  }

  @override
  Future<void> syncWeeklyRemote({required String weekKey, int limit = 50}) async {
    final remote = await _remote.fetchWeeklyTop(weekKey: weekKey, limit: limit);
    await _sqlite.upsertWeekly(weekKey, remote);
  }
}
