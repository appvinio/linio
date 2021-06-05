part of linio;

class UpTimeLinioHeader extends LinioHeaderFooter {
  final upTimeStart = DateTime.now();

  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return "${DateTime.now().difference(upTimeStart).toString()} $log";
  }
}
