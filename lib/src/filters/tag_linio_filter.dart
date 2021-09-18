part of linio;

class TagLinioFilter extends LinioFilter {
  @override
  bool shouldLog(LinioOptions options) {
    return Linio.instance.tagManager.shouldLog(options);
  }
}