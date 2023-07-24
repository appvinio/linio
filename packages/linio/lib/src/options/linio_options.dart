part of linio;

class LinioOptions {
  final LinioLogType type;
  final LinioLogLevel level;
  final String tag;
  // final ArgResults command;

  const LinioOptions(
    this.type,
    this.level,
    this.tag,
    // this.log,
    /*this.command*/
  );

  const LinioOptions.standard()
      : type = LinioLogType.static,
        level = LinioLogLevel.debug,
        tag = "";
  // command = ArgResults();
}
