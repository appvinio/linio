part of linio;

abstract class LinioFilter implements Initiable {
  bool shouldLog(LinioOptions options);

  @override
  void init(Linio instance) {}
}