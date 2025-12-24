sealed class SplashState {
  const SplashState();
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading(this.message);
  final String message;
}

final class SplashReady extends SplashState {
  const SplashReady();
}

final class SplashFailure extends SplashState {
  const SplashFailure(this.message);
  final String message;
}
