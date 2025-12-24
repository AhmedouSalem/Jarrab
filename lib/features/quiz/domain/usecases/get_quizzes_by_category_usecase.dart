import '../repositories/quiz_catalog_repository.dart';

class GetQuizzesByCategoryUseCase {
  GetQuizzesByCategoryUseCase(this._repo);
  final QuizCatalogRepository _repo;

  Future<CategoryWithQuizzes> call(String categoryId) {
    return _repo.loadQuizzesByCategory(categoryId);
  }
}
