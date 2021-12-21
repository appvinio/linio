part of linio;

class LevelLinioHeader extends LinioHeaderFooter {
  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    switch (options.level) {
      case LinioLogLevel.debug:
        return "[DEBUG] $log";
      case LinioLogLevel.info:
        return "[INFO ] $log";
      case LinioLogLevel.warn:
        return "[WARN ] $log";
      case LinioLogLevel.error:
        return "[ERROR] $log";
      case LinioLogLevel.fatal:
        return "[FATAL] $log";
    }
  }
}