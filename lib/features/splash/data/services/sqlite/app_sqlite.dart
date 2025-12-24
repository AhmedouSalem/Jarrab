import 'package:jarrab/features/splash/data/services/sqlite/schema_v2.dart';
import 'package:jarrab/features/splash/data/services/sqlite/schema_v3.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'schema_v1.dart';

class AppSqlite {
  static const _dbName = 'app.db';
  static const _dbVersion = 1;

  Database? _db;

  Future<Database> open() async {
    if (_db != null) return _db!;

    final dir = await getDatabasesPath();
    final path = p.join(dir, _dbName);

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await SchemaV1.create(db);
        await SchemaV2.upgrade(db);
        await SchemaV3.upgrade(db);
      },
      onUpgrade: (db, oldV, newV) async {
        if (oldV < 2) {
          await SchemaV2.upgrade(db);
        }
        if (oldV < 3) {
          await SchemaV3.upgrade(db);
        }
      },
    );

    return _db!;
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
