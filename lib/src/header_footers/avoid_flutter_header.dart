part of linio;

class AvoidFlutterHeader extends LinioHeaderFooter {

  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return '\r$log';
  }
}