import 'package:flutter/material.dart';
import 'package:jarrab/core/di/injection.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injection.I.init();

  runApp(App(router: Injection.I.router));
}
