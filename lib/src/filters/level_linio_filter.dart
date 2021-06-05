part of linio;

class LevelLinioFilter extends LinioFilter {
  @override
  bool shouldLog(LinioOptions options) {
    return Linio.instance.levelManager.shouldLog(options.level);
  }
}