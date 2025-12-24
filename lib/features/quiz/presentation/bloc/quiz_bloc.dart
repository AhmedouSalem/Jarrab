import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarrab/features/quiz/data/models/quiz_result_extra.dart';

import '../../domain/entities/quiz_entities.dart';
import '../../domain/usecases/get_quiz_session_usecase.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({required GetQuizSessionUseCase getSession})
    : _getSession = getSession,
      super(const QuizLoading()) {
    on<QuizStarted>(_onStarted);
    on<AnswerSelected>(_onSelected);
    on<NextPressed>(_onNext);
    on<Tick>(_onTick);
  }

  final GetQuizSessionUseCase _getSession;

  QuizSession? _session;
  int _qIndex = 0;
  int _selected = -1;
  int _remaining = 0;
  int _correct = 0;

  Timer? _timer;

  Future<void> _onStarted(QuizStarted e, Emitter<QuizState> emit) async {
    emit(const QuizLoading());
    _cancelTimer();

    try {
      _session = await _getSession(e.quizId);
      _qIndex = 0;
      _selected = -1;
      _correct = 0;
      _startQuestionTimer();

      emit(_buildInProgressState());
    } catch (err) {
      emit(QuizFailure(err.toString()));
    }
  }

  void _onSelected(AnswerSelected e, Emitter<QuizState> emit) {
    final s = state;
    if (s is! QuizInProgress) return;

    _selected = e.index;
    emit(_buildInProgressState());
  }

  void _onNext(NextPressed e, Emitter<QuizState> emit) {
    final session = _session;
    if (session == null) return;

    final currentQ = session.questions[_qIndex];
    final isCorrect = (_selected != -1 && _selected == currentQ.correctIndex);
    if (isCorrect) _correct++;

    final last = _qIndex >= session.questions.length - 1;
    if (last) {
      _cancelTimer();
      final total = session.questions.length;
      final points = _computePoints(
        correctCount: _correct,
        totalQuestions: total,
        difficulty: session.quiz.difficulty,
      );

      emit(
        QuizFinished(
          QuizResultExtra(
            quizId: session.quiz.id,
            quizTitle: session.quiz.title,
            difficulty: session.quiz.difficulty,
            totalQuestions: total,
            correctCount: _correct,
            pointsEarned: points,
            completedAtIso: DateTime.now().toUtc().toIso8601String(),
          ),
        ),
      );
      return;
    }

    // Next question
    _qIndex++;
    _selected = -1;
    _startQuestionTimer();
    emit(_buildInProgressState());
  }

  void _onTick(Tick e, Emitter<QuizState> emit) {
    final s = state;
    if (s is! QuizInProgress) return;

    _remaining = (_remaining - 1).clamp(0, 1 << 30);
    if (_remaining <= 0) {
      // time out => question counted as wrong
      add(const NextPressed());
      return;
    }
    emit(_buildInProgressState());
  }

  QuizInProgress _buildInProgressState() {
    final session = _session!;
    final q = session.questions[_qIndex];
    return QuizInProgress(
      quizId: session.quiz.id,
      quizTitle: session.quiz.title,
      difficulty: session.quiz.difficulty,
      currentIndex: _qIndex,
      total: session.questions.length,
      questionText: q.text,
      options: q.options,
      remainingSeconds: _remaining,
      selectedIndex: _selected,
      correctCountSoFar: _correct,
    );
  }

  void _startQuestionTimer() {
    final session = _session!;
    _cancelTimer();
    _remaining = session.quiz.timePerQuestionSec;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const Tick());
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  int _computePoints({
    required int correctCount,
    required int totalQuestions,
    required String difficulty,
  }) {
    final base = correctCount * 1.2;

    final mult = switch (difficulty) {
      'hard' => 1.5,
      'medium' => 1.2,
      _ => 1.0,
    };

    final perfectBonus = (correctCount == totalQuestions) ? 10 : 0;

    final pts = (base * mult).round() + perfectBonus;
    return pts;
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}
