CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  iconKey TEXT,
  imageUrl TEXT,
  orderIndex INTEGER NOT NULL,
  questionCount INTEGER DEFAULT 0,
  isActive INTEGER NOT NULL DEFAULT 1,
  updatedAt INTEGER NOT NULL
);

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

CREATE INDEX idx_quizzes_category ON quizzes(categoryId);
CREATE INDEX idx_quizzes_featured ON quizzes(isFeatured);

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

CREATE INDEX idx_questions_quiz ON questions(quizId);

CREATE TABLE user_profile (
  uid TEXT PRIMARY KEY,
  displayName TEXT,
  bio TEXT,
  avatarUrl TEXT,
  role TEXT NOT NULL DEFAULT 'user',
  isAnonymous INTEGER NOT NULL DEFAULT 1,
  updatedAt INTEGER NOT NULL
);

CREATE TABLE user_stats (
  uid TEXT PRIMARY KEY,
  quizzesTaken INTEGER NOT NULL DEFAULT 0,
  totalCorrect INTEGER NOT NULL DEFAULT 0,
  totalQuestions INTEGER NOT NULL DEFAULT 0,
  accuracy REAL NOT NULL DEFAULT 0,
  streakDays INTEGER NOT NULL DEFAULT 0,
  lastPlayDate INTEGER,
  level INTEGER NOT NULL DEFAULT 1,
  xp INTEGER NOT NULL DEFAULT 0,
  xpToNextLevel INTEGER NOT NULL DEFAULT 100,
  updatedAt INTEGER NOT NULL
);

CREATE TABLE attempts (
  id TEXT PRIMARY KEY,
  uid TEXT NOT NULL,
  quizId TEXT NOT NULL,
  quizTitle TEXT,
  categoryId TEXT,
  correctCount INTEGER NOT NULL,
  totalQuestions INTEGER NOT NULL,
  accuracy REAL NOT NULL,
  pointsEarned INTEGER NOT NULL,
  completedAt INTEGER NOT NULL,
  syncStatus TEXT NOT NULL  -- PENDING | SYNCED | FAILED
);

CREATE INDEX idx_attempts_uid_date ON attempts(uid, completedAt DESC);

CREATE TABLE achievements (
  id TEXT NOT NULL,
  uid TEXT NOT NULL,
  title TEXT NOT NULL,
  unlocked INTEGER NOT NULL DEFAULT 0,
  unlockedAt INTEGER,
  progress INTEGER,
  target INTEGER,
  PRIMARY KEY (id, uid)
);

CREATE TABLE leaderboard_entries (
  periodKey TEXT NOT NULL,      -- weekly:2025-W52 | allTime
  uid TEXT NOT NULL,
  displayName TEXT,
  avatarUrl TEXT,
  score INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL,
  PRIMARY KEY (periodKey, uid)
);

CREATE INDEX idx_lb_period_score ON leaderboard_entries(periodKey, score DESC);

CREATE TABLE app_settings (
  key TEXT PRIMARY KEY,
  value TEXT
);

CREATE TABLE sync_meta (
  key TEXT PRIMARY KEY,         -- categories | quizzes | questions:quizId | leaderboard_weekly:2025-W52 ...
  lastSyncedAt INTEGER NOT NULL
);

-- ===== Categories
INSERT INTO categories (id, name, iconKey, imageUrl, orderIndex, questionCount, isActive, updatedAt) VALUES
('literature','Literature','book',NULL,1,120,1,1734951600000),
('chemistry','Chemistry','flask',NULL,2,95,1,1734951600000),
('geography','Geography','globe',NULL,3,76,1,1734951600000),
('psychology','Psychology','brain',NULL,4,60,1,1734951600000);

-- ===== Quizzes
INSERT INTO quizzes (id, categoryId, title, subtitle, difficulty, timePerQuestionSec, questionCount, isFeatured, isPublic, coverImageUrl, updatedAt) VALUES
('science_olympiad_prep','chemistry','Science Olympiad Prep','Master advanced concepts and prepare for the next level.','hard',30,5,1,1,NULL,1734951600000),
('general_knowledge_mix','geography','General Knowledge','Challenge yourself with mixed questions.','medium',25,5,1,1,NULL,1734951600000),
('literature_basics','literature','Literature Basics','From classics to modern authors.','easy',25,5,0,1,NULL,1734951600000),
('mind_hacks','psychology','Mind Hacks','Test your psychology knowledge.','medium',25,5,0,1,NULL,1734951600000);

-- ===== Questions (optionsJson en JSON string)
INSERT INTO questions (id, quizId, orderIndex, text, optionsJson, correctIndex, explanation, imageUrl, updatedAt) VALUES
('gk_q1','general_knowledge_mix',1,'What is the capital of France?','["Berlin","Madrid","Paris","Rome"]',2,'Paris is the capital of France.',NULL,1734951600000),
('gk_q2','general_knowledge_mix',2,'Which planet is known as the Red Planet?','["Earth","Mars","Jupiter","Venus"]',1,'Mars is known as the Red Planet.',NULL,1734951600000),
('gk_q3','general_knowledge_mix',3,'Which ocean is the largest?','["Indian","Pacific","Atlantic","Arctic"]',1,NULL,NULL,1734951600000),
('gk_q4','general_knowledge_mix',4,'Mount Everest is located in which range?','["Andes","Alps","Himalayas","Rockies"]',2,NULL,NULL,1734951600000),
('gk_q5','general_knowledge_mix',5,'Which country has the city of Kyoto?','["China","Japan","Korea","Thailand"]',1,NULL,NULL,1734951600000),

('sp_q1','science_olympiad_prep',1,'What is the pH of a neutral solution at 25°C?','["0","7","10","14"]',1,NULL,NULL,1734951600000),
('sp_q2','science_olympiad_prep',2,'Which particle has a negative charge?','["Proton","Neutron","Electron","Nucleus"]',2,NULL,NULL,1734951600000),
('sp_q3','science_olympiad_prep',3,'Water''s chemical formula is:','["H2O","CO2","NaCl","O2"]',0,NULL,NULL,1734951600000),
('sp_q4','science_olympiad_prep',4,'Avogadro’s number is approximately:','["6.02×10^23","3.14","9.81","1.60×10^-19"]',0,NULL,NULL,1734951600000),
('sp_q5','science_olympiad_prep',5,'Which bond involves sharing electron pairs?','["Ionic","Covalent","Metallic","Hydrogen"]',1,NULL,NULL,1734951600000);

-- ===== User profile (local)
INSERT INTO user_profile (uid, displayName, bio, avatarUrl, role, isAnonymous, updatedAt) VALUES
('you','You','Always looking for new challenges and quizzes!',NULL,'user',1,1734951600000);

-- ===== Stats (local)
INSERT INTO user_stats (uid, quizzesTaken, totalCorrect, totalQuestions, accuracy, streakDays, lastPlayDate, level, xp, xpToNextLevel, updatedAt) VALUES
('you',124,880,1000,0.88,15,1734955080000,5,6420,8000,1734955080000);

-- ===== Achievements (local)
INSERT INTO achievements (id, uid, title, unlocked, unlockedAt, progress, target) VALUES
('quiz_master','you','Quiz Master',1,1733955600000,NULL,NULL),
('perfect_score','you','Perfect Score',1,1734512400000,NULL,NULL),
('daily_streak','you','Daily Streak',1,1734946800000,15,30);

-- ===== Attempts (local) + syncStatus
INSERT INTO attempts (id, uid, quizId, quizTitle, categoryId, correctCount, totalQuestions, accuracy, pointsEarned, completedAt, syncStatus) VALUES
('att_biology_basics','you','science_olympiad_prep','Biology Basics Quiz','chemistry',85,100,0.85,1440,1734947880000,'SYNCED'),
('att_art_history','you','literature_basics','History of Art Exam','literature',72,100,0.72,1200,1734874200000,'SYNCED'),
('att_math_algebra','you','general_knowledge_mix','Math Challenge: Algebra','geography',91,100,0.91,1600,1734782700000,'SYNCED');

-- ===== Leaderboard cache
INSERT INTO leaderboard_entries (periodKey, uid, displayName, avatarUrl, score, updatedAt) VALUES
('allTime','ava','Ava Johnson',NULL,12500,1734951600000),
('allTime','liam','Liam Smith',NULL,11800,1734951600000),
('allTime','noah','Noah Lee',NULL,10200,1734951600000),
('allTime','you','You',NULL,6800,1734951600000),

('weekly:2025-W52','ava','Ava Johnson',NULL,2500,1734951600000),
('weekly:2025-W52','liam','Liam Smith',NULL,1800,1734951600000),
('weekly:2025-W52','noah','Noah Lee',NULL,1200,1734951600000),
('weekly:2025-W52','you','You',NULL,680,1734951600000);

-- ===== Settings (optionnel)
INSERT INTO app_settings (key, value) VALUES
('locale','en'),
('themeMode','system'),
('soundEnabled','true'),
('hapticsEnabled','true'),
('pushEnabled','false');
