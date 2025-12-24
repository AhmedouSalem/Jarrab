import 'package:sqflite/sqflite.dart';

class SchemaV2 {
  static Future<void> upgrade(Database db) async {
    // ---- attempts (local mirror of users/{uid}/attempts/{attemptId})
    await db.execute('''
CREATE TABLE IF NOT EXISTS attempts (
  id TEXT PRIMARY KEY,
  uid TEXT NOT NULL,
  quizId TEXT NOT NULL,
  categoryId TEXT,
  quizTitle TEXT,
  correctCount INTEGER NOT NULL,
  totalQuestions INTEGER NOT NULL,
  accuracy REAL NOT NULL,
  pointsEarned INTEGER NOT NULL,
  completedAt INTEGER NOT NULL
);
''');

    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_attempts_uid ON attempts(uid);',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_attempts_quizId ON attempts(quizId);',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_attempts_completedAt ON attempts(completedAt);',
    );

    // ---- user_stats (local mirror of users/{uid}/stats/main)
    await db.execute('''
CREATE TABLE IF NOT EXISTS user_stats (
  uid TEXT PRIMARY KEY,
  streakDays INTEGER NOT NULL DEFAULT 0,
  totalQuestions INTEGER NOT NULL DEFAULT 0,
  totalCorrect INTEGER NOT NULL DEFAULT 0,
  quizzesTaken INTEGER NOT NULL DEFAULT 0,
  accuracy REAL NOT NULL DEFAULT 0,
  xp INTEGER NOT NULL DEFAULT 0,
  level INTEGER NOT NULL DEFAULT 1,
  xpToNextLevel INTEGER NOT NULL DEFAULT 8000,
  lastPlayDate INTEGER,
  updatedAt INTEGER NOT NULL
);
''');

    // ---- leaderboard local (all-time + weekly)
    await db.execute('''
CREATE TABLE IF NOT EXISTS leaderboard_all_time (
  uid TEXT PRIMARY KEY,
  displayName TEXT,
  avatarUrl TEXT,
  score INTEGER NOT NULL DEFAULT 0,
  updatedAt INTEGER NOT NULL
);
''');

    await db.execute('''
CREATE TABLE IF NOT EXISTS leaderboard_weekly (
  weekKey TEXT NOT NULL,
  uid TEXT NOT NULL,
  displayName TEXT,
  avatarUrl TEXT,
  score INTEGER NOT NULL DEFAULT 0,
  updatedAt INTEGER NOT NULL,
  PRIMARY KEY (weekKey, uid)
);
''');

    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_lb_weekly_week ON leaderboard_weekly(weekKey);',
    );
  }
}
