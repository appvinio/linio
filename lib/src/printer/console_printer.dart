part of linio;

class ConsolePrinter extends LinioPrinter {
  ConsolePrinter({List<LinioHeaderFooter> headers = const []})
      : super(headers: headers);

  String lastLive = '';

  @override
  void printLog(ArgResults command, List<String> log, LinioOptions options) {
    switch (options.type) {
      case LinioLogType.static:
        for (int i = 0; i < log.length; i++) {
          final element = log[i];
          if (i == log.length - 1) {
            // stdout.write('\r$element');
            print('\r$element');
          } else {
            // stdout.writeln('\r$element');
            print('\r$element');
          }
        }
        if (lastLive.isNotEmpty == true) {
          // stdout.write('\n');
          print('\n');
          // stdout.write(lastLive);
          print(lastLive);
        }
        break;
      case LinioLogType.live:
      // stdout.write('\x1B[1A');
        final logText = '\r${log.join(' -- ')}';
        // stdout.write(logText);
        print(logText);
        lastLive = logText;
        break;
    }
  }
}