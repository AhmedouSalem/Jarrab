import 'package:firebase_auth/firebase_auth.dart';
import 'package:jarrab/features/splash/domain/repositories/splash_repository.dart';
import 'package:jarrab/features/splash/domain/usecases/sync_user_outbox_usecase.dart';
import 'dart:async';

import '../../../../core/di/injection.dart';

class InitAppUseCase {
  InitAppUseCase(
      this._repo, {
        required FirebaseAuth auth,
        required SyncUserOutboxUseCase syncOutbox,
      })  : _auth = auth,
        _syncOutbox = syncOutbox;

  final SplashRepository _repo;
  final FirebaseAuth _auth;
  final SyncUserOutboxUseCase _syncOutbox;

  Future<void> call() async {
    await _repo.initLocal();
    await _repo.ensureAnonymousUser();
    await _repo.syncLight();

    // ✅ fire-and-forget sync vers Firestore
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      unawaited(
        _syncOutbox(uid: uid).catchError((_) {
          //
        }),
      );
    }
  }
}
