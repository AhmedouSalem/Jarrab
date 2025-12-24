import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/home_models.dart';
import '../../domain/usecases/load_home_usecase.dart';
import '../../domain/usecases/refresh_home_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required LoadHomeUseCase loadHome,
    required RefreshHomeUseCase refreshHome,
  }) : _loadHome = loadHome,
       _refreshHome = refreshHome,
       super(const HomeLoading()) {
    on<HomeStarted>(_onStarted);
    on<HomeRefreshRequested>(_onRefresh);
    on<HomeSearchChanged>(_onSearchChanged);
  }

  final LoadHomeUseCase _loadHome;
  final RefreshHomeUseCase _refreshHome;

  List<HomeCategory> _allCategories = const [];
  List<FeaturedQuiz> _allFeatured = const [];
  String _query = '';

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      final (categories, featured) = await _loadHome();
      _allCategories = categories;
      _allFeatured = featured;

      final filtered = _applyFilter(_query);
      emit(
        HomeLoaded(
          categories: filtered.$1,
          featured: filtered.$2,
          query: _query,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefresh(
    HomeRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _refreshHome();
    } finally {
      add(const HomeStarted());
    }
  }

  void _onSearchChanged(HomeSearchChanged event, Emitter<HomeState> emit) {
    _query = event.query;

    if (_allCategories.isEmpty && _allFeatured.isEmpty) return;

    final filtered = _applyFilter(_query);

    final current = state;
    if (current is HomeLoaded) {
      emit(
        current.copyWith(
          categories: filtered.$1,
          featured: filtered.$2,
          query: _query,
        ),
      );
    } else {
      emit(
        HomeLoaded(
          categories: filtered.$1,
          featured: filtered.$2,
          query: _query,
        ),
      );
    }
  }

  (List<HomeCategory>, List<FeaturedQuiz>) _applyFilter(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return (_allCategories, _allFeatured);

    final cats = _allCategories
        .where((c) => c.name.toLowerCase().contains(q))
        .toList();

    final featured = _allFeatured.where((f) {
      final t = f.title.toLowerCase();
      final s = f.subtitle.toLowerCase();
      return t.contains(q) || s.contains(q);
    }).toList();

    return (cats, featured);
  }
}
