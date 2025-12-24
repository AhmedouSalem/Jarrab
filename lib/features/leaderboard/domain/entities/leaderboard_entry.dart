class LeaderboardEntry {
  const LeaderboardEntry({
    required this.uid,
    required this.displayName,
    required this.score,
    this.avatarUrl,
  });

  final String uid;
  final String displayName;
  final int score;
  final String? avatarUrl;
}
