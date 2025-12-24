import 'package:sqflite/sqflite.dart';

class SchemaV1 {
  static Future<void> create(Database db) async {
    await db.execute('''
CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  iconKey TEXT,
  imageUrl TEXT,
  orderIndex INTEGER NOT NULL,
  quizCount INTEGER DEFAULT 0,
  isActive INTEGER NOT NULL DEFAULT 1,
  updatedAt INTEGER NOT NULL
);
''');

    await db.execute('''
CREATE TABLE quizzes (
  id TEXT PRIMARY KEY,
  categoryId TEXT NOT NULL,
  title TEXT NOT NULL,
  subtitle TEXT,
  difficulty TEXT NOT NULL,
  timePerQuestionSec INTEGER NOT NULL,
  questionCount INTEGER NOT NULL,
  isFeatured INTEGER NOT NULL DEFAULT 0,
  isPublic INTEGER NOT NULL DEFAULT 1,
  coverImageUrl TEXT,
  updatedAt INTEGER NOT NULL
);
''');

    await db.execute(
      'CREATE INDEX idx_quizzes_category ON quizzes(categoryId);',
    );
    await db.execute(
      'CREATE INDEX idx_quizzes_featured ON quizzes(isFeatured);',
    );

    await db.execute('''
CREATE TABLE questions (
  id TEXT PRIMARY KEY,
  quizId TEXT NOT NULL,
  orderIndex INTEGER NOT NULL,
  text TEXT NOT NULL,
  optionsJson TEXT NOT NULL,
  correctIndex INTEGER NOT NULL,
  explanation TEXT,
  imageUrl TEXT,
  updatedAt INTEGER NOT NULL
);
''');

    await db.execute('CREATE INDEX idx_questions_quiz ON questions(quizId);');

    await db.execute('''
CREATE TABLE sync_meta (
  key TEXT PRIMARY KEY,
  lastSyncedAt INTEGER NOT NULL
);
''');
  }
}
