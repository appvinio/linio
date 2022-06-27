part of linio;

class TagLinioFilter extends LinioFilter {
  late final LinioTagManager manager;

  @override
  bool shouldLog(LinioOptions options) {
    return manager.shouldLog(options);
  }

  @override
  void init(Linio instance) {
    manager = instance.tagManager;
    super.init(instance);
  }
}
