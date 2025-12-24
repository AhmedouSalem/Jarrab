sealed class CategoryQuizzesEvent {
  const CategoryQuizzesEvent();
}

final class CategoryQuizzesStarted extends CategoryQuizzesEvent {
  const CategoryQuizzesStarted(this.categoryId);
  final String categoryId;
}
