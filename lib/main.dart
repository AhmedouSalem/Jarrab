import 'package:flutter/material.dart';
import 'package:jarrab/core/di/injection.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: init Firebase here (Firebase.initializeApp)

  runApp(App(router: router));

  // TODO: brancher session à FirebaseAuth:
  // FirebaseAuth.instance.authStateChanges().listen((user) {
  //   session.setAuthenticated(user != null);
  // });
}
