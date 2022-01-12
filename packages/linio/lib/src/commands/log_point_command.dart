part of linio;

class LogPointCommand extends LinioCommand {
  final name = "log_point";
  final description = "Log Point";

  LogPointCommand() {
    argParser.addOption('log_point');
  }

  run() {
    final stackTraceLines = StackTrace.current.toString().split('\n');
    final preIndex =
    stackTraceLines.indexWhere((element) => element.contains('Linio'));
    final realIndex =
    stackTraceLines.indexWhere((element) => !element.contains('Linio'), preIndex);
    final line = stackTraceLines[realIndex];
    final startPointPrefix = line.indexOf('(');
    final lastPointPrefix = line.indexOf(')') + 1;
    final point = line.substring(startPointPrefix, lastPointPrefix);
    return [point];
  }
}