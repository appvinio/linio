part of linio;

class DateTimeLinioHeader extends LinioHeaderFooter {
  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return "${DateTime.now().toIso8601String()} $log";
  }
}