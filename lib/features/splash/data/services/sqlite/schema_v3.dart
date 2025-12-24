import 'package:sqflite/sqflite.dart';

class SchemaV3 {
  static Future<void> upgrade(Database db) async {
    await _addColumnIfMissing(db, table: 'attempts', column: 'isSynced', typeSql: 'INTEGER NOT NULL DEFAULT 0');
    await _addColumnIfMissing(db, table: 'attempts', column: 'syncedAt', typeSql: 'INTEGER');
  }

  static Future<void> _addColumnIfMissing(
      Database db, {
        required String table,
        required String column,
        required String typeSql,
      }) async {
    final cols = await db.rawQuery('PRAGMA table_info($table)');
    final exists = cols.any((c) => c['name'] == column);
    if (!exists) {
      await db.execute('ALTER TABLE $table ADD COLUMN $column $typeSql;');
    }
  }
}
