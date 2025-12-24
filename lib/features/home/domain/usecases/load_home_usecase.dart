import '../entities/home_models.dart';
import '../repositories/home_repository.dart';

class LoadHomeUseCase {
  LoadHomeUseCase(this._repo);
  final HomeRepository _repo;

  Future<(List<HomeCategory>, List<FeaturedQuiz>)> call() async {
    final categories = await _repo.loadCategories();
    final featured = await _repo.loadFeaturedQuizzes();
    return (categories, featured);
  }
}
