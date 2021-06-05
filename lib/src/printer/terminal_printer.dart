part of linio;

class TerminalPrinter extends LinioPrinter {
  TerminalPrinter({List<LinioHeaderFooter> headers = const []})
      : super(headers: headers);

  @override
  void printLog(ArgResults command, List<String> log, LinioOptions options) {
    log.forEach((element) {
      // stdout.writeln('\r$element');
     print('\r$element');
    });
  }
}