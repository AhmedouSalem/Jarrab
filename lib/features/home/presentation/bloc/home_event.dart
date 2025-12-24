sealed class HomeEvent {
  const HomeEvent();
}

final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

final class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}

final class HomeSearchChanged extends HomeEvent {
  const HomeSearchChanged(this.query);
  final String query;
}