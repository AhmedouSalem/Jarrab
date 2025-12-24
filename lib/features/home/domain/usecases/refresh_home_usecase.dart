import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jarrab/features/splash/domain/repositories/splash_repository.dart';

import '../../../splash/domain/usecases/sync_user_outbox_usecase.dart';
import 'dart:async';

class RefreshHomeUseCase {
  RefreshHomeUseCase(this._splashRepo, {
    required FirebaseAuth auth,
    required SyncUserOutboxUseCase syncOutbox,
  }): _auth = auth,
        _syncOutbox = syncOutbox;
  final SplashRepository _splashRepo;
  final FirebaseAuth _auth;
  final SyncUserOutboxUseCase _syncOutbox;

  Future<void> call() async {
    debugPrint('REFRESH USECASE: calling syncLight(force:true)');
    await _splashRepo.syncLight(force: true);
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      unawaited(
        _syncOutbox(uid: uid).catchError((_) {
          // option: log
        }),
      );
    }
  }
}
