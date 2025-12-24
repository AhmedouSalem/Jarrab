import 'package:jarrab/features/home/domain/entities/home_models.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.categories,
    required this.featured,
    this.query = '',
  });

  final List<HomeCategory> categories;
  final List<FeaturedQuiz> featured;
  final String query;

  HomeLoaded copyWith({
    List<HomeCategory>? categories,
    List<FeaturedQuiz>? featured,
    String? query,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      featured: featured ?? this.featured,
      query: query ?? this.query,
    );
  }
}

final class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;
}
