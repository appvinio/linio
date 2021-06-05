part of linio;

abstract class LinioPrinter {
  LinioPrinter({List<LinioHeaderFooter> headers = const []}) {
    this.headers.addAll(headers);
  }

  final List<LinioHeaderFooter> headers = [];

  void print(ArgResults command, List<String> log, LinioOptions options) {
    final logToPrint = log
        .fold(
        <String>[],
            (List<String> previousValue, String element) =>
        previousValue..addAll(element.split('\n')))
        .map((line) => headers.fold(
        line,
            (String previousValue, element) =>
            element.prepareHeader(command, previousValue, options)))
        .toList();
    printLog(command, logToPrint, options);
  }

  void printLog(ArgResults command, List<String> log, LinioOptions options);
}