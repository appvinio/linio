part of linio;

class LogPointCommand extends LinioCommand {
  // The [name] and [description] properties must be defined by every
  // subclass.
  final name = "log_point";
  final description = "Log Point";

  LogPointCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption('log_point');
  }

  // [run] may also return a Future.
  run() {
    final stackTraceLines = StackTrace.current.toString().split('\n');
    final preIndex =
    stackTraceLines.indexWhere((element) => element.contains('Linio'));
    final line = stackTraceLines[preIndex + 1];
    final startPointPrefix = line.indexOf('(');
    final lastPointPrefix = line.indexOf(')') + 1;
    final point = line.substring(startPointPrefix, lastPointPrefix);
    return [point];
  }
}