import '../entities/quiz_summary.dart';

class CategoryWithQuizzes {
  const CategoryWithQuizzes({
    required this.categoryId,
    required this.categoryName,
    required this.quizzes,
  });

  final String categoryId;
  final String categoryName;
  final List<QuizSummary> quizzes;
}

abstract class QuizCatalogRepository {
  Future<CategoryWithQuizzes> loadQuizzesByCategory(String categoryId);
}
