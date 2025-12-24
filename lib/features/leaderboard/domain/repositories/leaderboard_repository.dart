import '../entities/leaderboard_entry.dart';

abstract class LeaderboardRepository {
  Future<List<LeaderboardEntry>> loadAllTimeLocal({int limit = 50});
  Future<List<LeaderboardEntry>> loadWeeklyLocal({required String weekKey, int limit = 50});

  Future<void> syncAllTimeRemote({int limit = 50});
  Future<void> syncWeeklyRemote({required String weekKey, int limit = 50});
}
