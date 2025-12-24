
enum LeaderboardPeriod { weekly, allTime }

sealed class LeaderboardEvent {
  const LeaderboardEvent();
}

final class LeaderboardStarted extends LeaderboardEvent {
  const LeaderboardStarted();
}

final class LeaderboardPeriodChanged extends LeaderboardEvent {
  const LeaderboardPeriodChanged(this.period);
  final LeaderboardPeriod period;
}

final class LeaderboardRefreshed extends LeaderboardEvent {
  const LeaderboardRefreshed();
}