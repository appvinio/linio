part of linio;

class LiveLinioHeader extends LinioHeaderFooter {
  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    final livePostfix = options.type == LinioLogType.live ? "[LIVE ●]" : "";
    return "$log $livePostfix";
  }
}