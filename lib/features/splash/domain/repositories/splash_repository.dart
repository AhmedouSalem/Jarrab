abstract class SplashRepository {
  Future<void> initLocal();
  Future<void> ensureAnonymousUser();
  Future<void> syncLight({bool force});
}
