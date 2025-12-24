sealed class SplashEvent {
  const SplashEvent();
}

final class SplashStarted extends SplashEvent {
  const SplashStarted();
}

final class SplashRetry extends SplashEvent {
  const SplashRetry();
}
