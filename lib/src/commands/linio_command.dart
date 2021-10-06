part of linio;

abstract class LinioCommand extends Command<List<String>>
    implements LinioManipulator, Initiable {

  late final Linio linio;

  @override
  void init(Linio instance) {
    linio = instance;
  }
}

