part of linio;

class LevelLinioFilter extends LinioFilter {
  late final LinioLevelManager manager;
  @override
  bool shouldLog(LinioOptions options) {
    return manager.shouldLog(options.level);
  }

  @override
  void init(Linio instance) {
    manager = instance.levelManager;
    super.init(instance);
  }
}
