import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService(this._auth);
  final FirebaseAuth _auth;

  Future<User> ensureAnonymous() async {
    final current = _auth.currentUser;
    if (current != null) return current;

    final cred = await _auth.signInAnonymously();
    return cred.user!;
  }
}
