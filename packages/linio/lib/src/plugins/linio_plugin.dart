part of linio;

abstract class LinioPlugin implements Initiable {
  late final Linio linio;

  @override
  void init(Linio instance) {
    linio = instance;
  }
}
