import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/leaderboard_entry_model.dart';

class LeaderboardFirestoreService {
  LeaderboardFirestoreService(this._fs);
  final FirebaseFirestore _fs;

  Future<List<LeaderboardEntryModel>> fetchAllTimeTop({int limit = 50}) async {
    final snap = await _fs
        .collection('leaderboards_all_time')
        .doc('global')
        .collection('entries')
        .orderBy('score', descending: true)
        .limit(limit)
        .get();

    return snap.docs.map((d) => LeaderboardEntryModel.fromFirestore(d.id, d.data())).toList();
  }

  Future<List<LeaderboardEntryModel>> fetchWeeklyTop({
    required String weekKey,
    int limit = 50,
  }) async {
    final snap = await _fs
        .collection('leaderboards_weekly')
        .doc(weekKey)
        .collection('entries')
        .orderBy('score', descending: true)
        .limit(limit)
        .get();

    return snap.docs.map((d) => LeaderboardEntryModel.fromFirestore(d.id, d.data())).toList();
  }
}
