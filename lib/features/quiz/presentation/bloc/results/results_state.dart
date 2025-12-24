sealed class ResultsState {
  const ResultsState();
}

final class ResultsIdle extends ResultsState {
  const ResultsIdle();
}

final class ResultsSaving extends ResultsState {
  const ResultsSaving();
}

final class ResultsSaved extends ResultsState {
  const ResultsSaved();
}

final class ResultsSaveError extends ResultsState {
  const ResultsSaveError(this.message);
  final String message;
}
