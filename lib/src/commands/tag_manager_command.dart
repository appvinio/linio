part of linio;

class TagManagerCommand extends LinioCommand {
  // The [name] and [description] properties must be defined by every
  // subclass.
  final name = "tag_manager";
  final description = "TagManager";

  Map<String, Stopwatch> stopwatches = {};

  TagManagerCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption('allow', abbr: 'a');
    argParser.addOption('block', abbr: 'b');
  }

  // [run] may also return a Future.
  run() {
    if (argResults != null) {
      if (argResults!.wasParsed('allow')) {
        Linio.instance.tagManager.allow(argResults!['allow']);
      } else if (argResults!.wasParsed('block')) {
        Linio.instance.tagManager.block(argResults!['block']);
      }
    }
    return <String>[];
  }
}