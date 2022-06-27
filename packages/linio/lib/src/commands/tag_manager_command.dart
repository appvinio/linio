part of linio;

class TagManagerCommand extends LinioCommand {
  final name = "tag_manager";
  final description = "TagManager";

  Map<String, Stopwatch> stopwatches = {};

  TagManagerCommand() {
    argParser.addOption('allow', abbr: 'a');
    argParser.addOption('block', abbr: 'b');
  }

  run() {
    if (argResults != null) {
      if (argResults!.wasParsed('allow')) {
        linio.tagManager.allow(argResults!['allow']);
        return ['$description: Allow ${argResults!['allow']}'];
      } else if (argResults!.wasParsed('block')) {
        linio.tagManager.block(argResults!['block']);
        return ['$description: Block ${argResults!['block']}'];
      }
    }
    return [];
  }
}
