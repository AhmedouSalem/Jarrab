import 'package:jarrab/features/quiz/data/models/quiz_result_extra.dart';

sealed class ResultsEvent {
  const ResultsEvent();
}

final class ResultsStarted extends ResultsEvent {
  const ResultsStarted(this.result);
  final QuizResultExtra result;
}
