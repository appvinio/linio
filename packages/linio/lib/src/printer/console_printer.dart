part of linio;

class ConsolePrinter extends LinioPrinter {
  ConsolePrinter({List<LinioHeaderFooter> headers = const []}) : super(headers: headers);

  String lastLive = '';

  @override
  void printLog(ArgResults command, List<String> log, LinioOptions options) {
    switch (options.type) {
      case LinioLogType.static:
        for (int i = 0; i < log.length; i++) {
          final element = log[i];
          print('$element');
        }
        if (lastLive.isNotEmpty == true) {
          print('\n');
          print(lastLive);
        }
        break;
      case LinioLogType.live:
        final logText = '${log.join(' -- ')}';
        print(logText);
        lastLive = logText;
        break;
    }
  }
}
