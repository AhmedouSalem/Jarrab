import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_quizzes_by_category_usecase.dart';
import 'category_quizzes_event.dart';
import 'category_quizzes_state.dart';

class CategoryQuizzesBloc
    extends Bloc<CategoryQuizzesEvent, CategoryQuizzesState> {
  CategoryQuizzesBloc({required GetQuizzesByCategoryUseCase getByCategory})
    : _getByCategory = getByCategory,
      super(const CategoryQuizzesLoading()) {
    on<CategoryQuizzesStarted>(_onStarted);
  }

  final GetQuizzesByCategoryUseCase _getByCategory;

  Future<void> _onStarted(
    CategoryQuizzesStarted event,
    Emitter<CategoryQuizzesState> emit,
  ) async {
    emit(const CategoryQuizzesLoading());
    try {
      final data = await _getByCategory(event.categoryId);
      emit(CategoryQuizzesLoaded(data));
    } catch (e) {
      emit(CategoryQuizzesError(e.toString()));
    }
  }
}
