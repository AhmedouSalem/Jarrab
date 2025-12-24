import '../../domain/entities/leaderboard_entry.dart';

class LeaderboardEntryModel extends LeaderboardEntry {
  const LeaderboardEntryModel({
    required super.uid,
    required super.displayName,
    required super.score,
    super.avatarUrl,
  });

  factory LeaderboardEntryModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return LeaderboardEntryModel(
      uid: (data['uid'] as String?) ?? docId,
      displayName: (data['displayName'] as String?) ?? 'User',
      avatarUrl: data['avatarUrl'] as String?,
      score: (data['score'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, Object?> toSqlRowAllTime(int nowMs) => {
    'uid': uid,
    'displayName': displayName,
    'avatarUrl': avatarUrl,
    'score': score,
    'updatedAt': nowMs,
  };

  Map<String, Object?> toSqlRowWeekly(String weekKey, int nowMs) => {
    'weekKey': weekKey,
    'uid': uid,
    'displayName': displayName,
    'avatarUrl': avatarUrl,
    'score': score,
    'updatedAt': nowMs,
  };
}
