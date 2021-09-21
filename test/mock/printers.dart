import 'package:linio/linio.dart';

class TestConsole extends LinioPrinter {
  final List<String> logs = [];

  @override
  void printLog(ArgResults command, List<String> log, LinioOptions options) {
    logs.addAll(log);
    log.forEach(print);
  }
}