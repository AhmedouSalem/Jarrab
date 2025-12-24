import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/usecases/commit_quiz_result_usecase.dart';
import 'results_event.dart';
import 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  ResultsBloc({
    required CommitQuizResultUseCase commit,
    required FirebaseAuth auth,
  }) : _commit = commit,
       _auth = auth,
       super(const ResultsIdle()) {
    on<ResultsStarted>(_onStarted);
  }

  final CommitQuizResultUseCase _commit;
  final FirebaseAuth _auth;

  bool _doneOnce = false;

  Future<void> _onStarted(ResultsStarted e, Emitter<ResultsState> emit) async {
    if (_doneOnce) return;
    _doneOnce = true;

    emit(const ResultsSaving());
    try {
      final user = _auth.currentUser;
      final uid = user?.uid;
      if (uid == null) throw StateError('No current user (anonymous)');
      await _commit(
        uid: uid,
        result: e.result,
        displayName: user?.displayName,
        avatarUrl: user?.photoURL,
      );

      emit(const ResultsSaved());
    } catch (err) {
      emit(ResultsSaveError(err.toString()));
    }
  }
}
