import '../entities/home_models.dart';

abstract class HomeRepository {
  Future<List<HomeCategory>> loadCategories();
  Future<List<FeaturedQuiz>> loadFeaturedQuizzes();
}
