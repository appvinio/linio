part of linio;

class AvoidFlutterHeader extends LinioHeaderFooter {
  const AvoidFlutterHeader();

  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return '\r$log';
  }
}
