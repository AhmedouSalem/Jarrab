import '../../domain/entities/leaderboard_entry.dart';
import 'leaderboard_event.dart';

sealed class LeaderboardState {
  const LeaderboardState();
}

final class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

final class LeaderboardLoaded extends LeaderboardState {
  const LeaderboardLoaded({
    required this.period,
    required this.entries,
    required this.weekKey,
    required this.myUid,
    required this.isRefreshing,
  });

  final LeaderboardPeriod period;
  final List<LeaderboardEntry> entries;
  final String weekKey;
  final String myUid;
  final bool isRefreshing;

  LeaderboardEntry? get me => entries.firstWhere(
        (e) => e.uid == myUid,
    orElse: () => LeaderboardEntry(uid: myUid, displayName: 'You', score: 0),
  );

  int? get myRank {
    final idx = entries.indexWhere((e) => e.uid == myUid);
    if (idx == -1) return null;
    return idx + 1;
  }

  List<LeaderboardEntry> get top3 => entries.take(3).toList();

  List<LeaderboardEntry> get rest {
    final setTop = top3.map((e) => e.uid).toSet();
    return entries.where((e) => !setTop.contains(e.uid) && e.uid != myUid).toList();
  }
}

final class LeaderboardError extends LeaderboardState {
  const LeaderboardError(this.message);
  final String message;
}