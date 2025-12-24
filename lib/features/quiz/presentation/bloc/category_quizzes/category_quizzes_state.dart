import '../../../domain/repositories/quiz_catalog_repository.dart';

sealed class CategoryQuizzesState {
  const CategoryQuizzesState();
}

final class CategoryQuizzesLoading extends CategoryQuizzesState {
  const CategoryQuizzesLoading();
}

final class CategoryQuizzesLoaded extends CategoryQuizzesState {
  const CategoryQuizzesLoaded(this.data);
  final CategoryWithQuizzes data;
}

final class CategoryQuizzesError extends CategoryQuizzesState {
  const CategoryQuizzesError(this.message);
  final String message;
}
