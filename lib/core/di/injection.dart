import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

import 'package:jarrab/core/routing/app_router.dart';
import 'package:jarrab/features/home/data/repositories/home_repository_impl.dart';
import 'package:jarrab/features/home/domain/usecases/load_home_usecase.dart';
import 'package:jarrab/features/home/domain/usecases/refresh_home_usecase.dart';
import 'package:jarrab/features/home/presentation/bloc/home_bloc.dart';
import 'package:jarrab/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:jarrab/features/quiz/data/repositories/quiz_catalog_repository_impl.dart';
import 'package:jarrab/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:jarrab/features/quiz/domain/usecases/commit_quiz_result_usecase.dart';
import 'package:jarrab/features/quiz/domain/usecases/get_quiz_session_usecase.dart';
import 'package:jarrab/features/quiz/domain/usecases/get_quizzes_by_category_usecase.dart';
import 'package:jarrab/features/quiz/presentation/bloc/category_quizzes/category_quizzes_bloc.dart';
import 'package:jarrab/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:jarrab/features/quiz/presentation/bloc/results/results_bloc.dart';

import 'package:jarrab/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:jarrab/features/splash/data/services/firebase/firebase_auth_service.dart';
import 'package:jarrab/features/splash/data/services/firebase/firestore_seed_sync_service.dart';
import 'package:jarrab/features/splash/data/services/sqlite/app_sqlite.dart';
import 'package:jarrab/features/splash/domain/usecases/init_app_usecase.dart';
import 'package:jarrab/features/splash/presentation/bloc/splash_bloc.dart';

import '../../features/leaderboard/data/repositories/leaderboard_repository_impl.dart';
import '../../features/leaderboard/presentation/bloc/leaderboard_bloc.dart';
import '../../features/splash/domain/usecases/sync_user_outbox_usecase.dart';
import '../../firebase_options.dart';

class Injection {
  Injection._();
  static final Injection I = Injection._();

  // Core
  late final AuthSession session;
  late final GoRouter router;

  // External
  late final FirebaseAuth firebaseAuth;
  late final FirebaseFirestore firestore;
  late final AppSqlite sqlite;

  // Services
  late final FirebaseAuthService firebaseAuthService;
  late final FirestoreSeedSyncService seedSyncService;

  // Repos / Usecases
  late final SplashRepositoryImpl splashRepository;
  late final InitAppUseCase initAppUseCase;
  late final HomeRepositoryImpl homeRepository;
  late final LoadHomeUseCase loadHomeUseCase;
  late final RefreshHomeUseCase refreshHomeUseCase;
  late final QuizRepositoryImpl quizRepository;
  late final GetQuizSessionUseCase getQuizSessionUseCase;
  late final QuizCatalogRepositoryImpl quizCatalogRepository;
  late final GetQuizzesByCategoryUseCase getQuizzesByCategoryUseCase;
  late final CommitQuizResultUseCase commitQuizResultUseCase;
  late final SyncUserOutboxUseCase syncUserOutboxUseCase;
  late final LeaderboardRepository leaderboardRepository;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Core routing
    session = AuthSession();
    router = buildRouter(session);

    // External
    firebaseAuth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    sqlite = AppSqlite();
    final db = await sqlite.open();

    // Services
    firebaseAuthService = FirebaseAuthService(firebaseAuth);
    seedSyncService = FirestoreSeedSyncService(firestore);

    // Splash
    splashRepository = SplashRepositoryImpl(
      sqlite: sqlite,
      authService: firebaseAuthService,
      seedSync: seedSyncService,
    );

    syncUserOutboxUseCase = SyncUserOutboxUseCase(db: db, fs: firestore);

    initAppUseCase = InitAppUseCase(
      splashRepository,
      auth: firebaseAuth,
      syncOutbox: syncUserOutboxUseCase,
    );


    homeRepository = HomeRepositoryImpl(db);
    loadHomeUseCase = LoadHomeUseCase(homeRepository);
    refreshHomeUseCase = RefreshHomeUseCase(splashRepository,
      auth: firebaseAuth,
      syncOutbox: syncUserOutboxUseCase,);

    quizRepository = QuizRepositoryImpl(db);
    getQuizSessionUseCase = GetQuizSessionUseCase(quizRepository);

    quizCatalogRepository = QuizCatalogRepositoryImpl(db);
    getQuizzesByCategoryUseCase = GetQuizzesByCategoryUseCase(
      quizCatalogRepository,
    );

    commitQuizResultUseCase = CommitQuizResultUseCase(db);
    leaderboardRepository = LeaderboardRepositoryImpl(
      db: db,
      fs: FirebaseFirestore.instance,
    );
  }

  /// Factory
  SplashBloc createSplashBloc() => SplashBloc(initApp: initAppUseCase);
  HomeBloc createHomeBloc() =>
      HomeBloc(loadHome: loadHomeUseCase, refreshHome: refreshHomeUseCase);
  QuizBloc createQuizBloc() => QuizBloc(getSession: getQuizSessionUseCase);
  CategoryQuizzesBloc createCategoryQuizzesBloc() =>
      CategoryQuizzesBloc(getByCategory: getQuizzesByCategoryUseCase);
  ResultsBloc createResultsBloc() =>
      ResultsBloc(commit: commitQuizResultUseCase, auth: FirebaseAuth.instance);
  LeaderboardBloc createLeaderboardBloc() => LeaderboardBloc(
    repo: leaderboardRepository,
    auth: FirebaseAuth.instance,
  );
}
