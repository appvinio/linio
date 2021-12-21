part of linio;

class LinioOptions {
  final LinioLogType type;
  final LinioLogLevel level;
  final String tag;
  final dynamic log;
  final ArgResults command;

  LinioOptions(this.type, this.level, this.tag, this.log, this.command);
}