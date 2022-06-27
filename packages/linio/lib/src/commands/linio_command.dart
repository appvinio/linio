part of linio;

abstract class LinioCommand extends Command<List<String>> implements Initiable {
  late final Linio linio;

  @override
  void init(Linio instance) {
    linio = instance;
  }
}
