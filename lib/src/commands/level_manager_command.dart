part of linio;

class LevelManagerCommand extends LinioCommand {
  // The [name] and [description] properties must be defined by every
  // subclass.
  final name = "level_manager";
  final description = "LevelManager";

  Map<String, Stopwatch> stopwatches = {};

  LevelManagerCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption('allow', abbr: 'a');
    argParser.addOption('block', abbr: 'b');
  }

  // [run] may also return a Future.
  run() {
    if (argResults != null) {
      if (argResults!.wasParsed('allow')) {
        Linio.instance.levelManager.allow(LinioLogLevel.values.firstWhere((element) => element.toString() == argResults!['allow']));
      } else if (argResults!.wasParsed('block')) {
        Linio.instance.levelManager.block(LinioLogLevel.values.firstWhere((element) => element.toString() == argResults!['block']));
      }
    }
    return <String>[];
  }
}