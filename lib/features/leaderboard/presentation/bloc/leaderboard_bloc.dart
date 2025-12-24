import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc({
    required LeaderboardRepository repo,
    required FirebaseAuth auth,
  })  : _repo = repo,
        _auth = auth,
        super(const LeaderboardLoading()) {
    on<LeaderboardStarted>(_onStarted);
    on<LeaderboardPeriodChanged>(_onPeriodChanged);
    on<LeaderboardRefreshed>(_onRefresh);
  }

  final LeaderboardRepository _repo;
  final FirebaseAuth _auth;

  Future<void> _onStarted(LeaderboardStarted e, Emitter<LeaderboardState> emit) async {
    final uid = _auth.currentUser?.uid ?? '';
    final weekKey = _weekKeyUtc(DateTime.now());

    // 1) local first
    final local = await _loadLocal(LeaderboardPeriod.weekly, weekKey);
    emit(LeaderboardLoaded(
      period: LeaderboardPeriod.weekly,
      entries: local,
      weekKey: weekKey,
      myUid: uid,
      isRefreshing: true,
    ));

    // 2) remote sync (non bloquant)
    unawaited(_syncRemote(LeaderboardPeriod.weekly, weekKey).then((_) async {
      final updated = await _loadLocal(LeaderboardPeriod.weekly, weekKey);
      if (!isClosed) {
        emit(LeaderboardLoaded(
          period: LeaderboardPeriod.weekly,
          entries: updated,
          weekKey: weekKey,
          myUid: uid,
          isRefreshing: false,
        ));
      }
    }).catchError((_) {
      if (!isClosed) {
        emit(LeaderboardLoaded(
          period: LeaderboardPeriod.weekly,
          entries: local,
          weekKey: weekKey,
          myUid: uid,
          isRefreshing: false,
        ));
      }
    }));
  }

  Future<void> _onPeriodChanged(LeaderboardPeriodChanged e, Emitter<LeaderboardState> emit) async {
    final uid = _auth.currentUser?.uid ?? '';
    final weekKey = _weekKeyUtc(DateTime.now());

    final local = await _loadLocal(e.period, weekKey);
    emit(LeaderboardLoaded(
      period: e.period,
      entries: local,
      weekKey: weekKey,
      myUid: uid,
      isRefreshing: true,
    ));

    unawaited(_syncRemote(e.period, weekKey).then((_) async {
      final updated = await _loadLocal(e.period, weekKey);
      if (!isClosed) {
        emit(LeaderboardLoaded(
          period: e.period,
          entries: updated,
          weekKey: weekKey,
          myUid: uid,
          isRefreshing: false,
        ));
      }
    }).catchError((_) {
      if (!isClosed) {
        emit(LeaderboardLoaded(
          period: e.period,
          entries: local,
          weekKey: weekKey,
          myUid: uid,
          isRefreshing: false,
        ));
      }
    }));
  }

  Future<void> _onRefresh(LeaderboardRefreshed e, Emitter<LeaderboardState> emit) async {
    final s = state;
    if (s is! LeaderboardLoaded) return;

    emit(LeaderboardLoaded(
      period: s.period,
      entries: s.entries,
      weekKey: s.weekKey,
      myUid: s.myUid,
      isRefreshing: true,
    ));

    try {
      await _syncRemote(s.period, s.weekKey);
      final updated = await _loadLocal(s.period, s.weekKey);
      emit(LeaderboardLoaded(
        period: s.period,
        entries: updated,
        weekKey: s.weekKey,
        myUid: s.myUid,
        isRefreshing: false,
      ));
    } catch (err) {
      emit(LeaderboardLoaded(
        period: s.period,
        entries: s.entries,
        weekKey: s.weekKey,
        myUid: s.myUid,
        isRefreshing: false,
      ));
    }
  }

  Future<List<LeaderboardEntry>> _loadLocal(LeaderboardPeriod p, String weekKey) {
    if (p == LeaderboardPeriod.allTime) {
      return _repo.loadAllTimeLocal(limit: 50);
    }
    return _repo.loadWeeklyLocal(weekKey: weekKey, limit: 50);
  }

  Future<void> _syncRemote(LeaderboardPeriod p, String weekKey) {
    if (p == LeaderboardPeriod.allTime) {
      return _repo.syncAllTimeRemote(limit: 50);
    }
    return _repo.syncWeeklyRemote(weekKey: weekKey, limit: 50);
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
