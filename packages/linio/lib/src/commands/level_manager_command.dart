part of linio;

class LevelManagerCommand extends LinioCommand {
  final name = "level_manager";
  final description = "LevelManager";

  Map<String, Stopwatch> stopwatches = {};

  LevelManagerCommand() {
    argParser.addOption('allow', abbr: 'a');
    argParser.addOption('block', abbr: 'b');
  }

  run() {
    if (argResults != null) {
      if (argResults!.wasParsed('allow')) {
        linio.levelManager
            .allow(LinioLogLevel.values.firstWhere((element) => element.toString().contains(argResults!['allow'])));
      } else if (argResults!.wasParsed('block')) {
        linio.levelManager
            .block(LinioLogLevel.values.firstWhere((element) => element.toString().contains(argResults!['block'])));
      }
    }
    return <String>[];
  }
}
