import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../../domain/repositories/splash_repository.dart';
import '../../domain/usecases/sync_user_outbox_usecase.dart';
import '../services/firebase/firebase_auth_service.dart';
import '../services/firebase/firestore_seed_sync_service.dart';
import '../services/sqlite/app_sqlite.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl({
    required AppSqlite sqlite,
    required FirebaseAuthService authService,
    required FirestoreSeedSyncService seedSync,
  }) : _sqlite = sqlite,
       _authService = authService,
       _seedSync = seedSync;

  final AppSqlite _sqlite;
  final FirebaseAuthService _authService;
  final FirestoreSeedSyncService _seedSync;

  Database? _db;

  @override
  Future<void> initLocal() async {
    _db = await _sqlite.open();
  }

  @override
  Future<void> ensureAnonymousUser() async {
    await _authService.ensureAnonymous();
  }

  @override
  Future<void> syncLight({bool force = false}) async {
    final db = _db ?? await _sqlite.open();
    debugPrint('SPLASH REPO: syncLight(force=$force)');
    await _seedSync.syncLight(db, force: force);
  }
}
