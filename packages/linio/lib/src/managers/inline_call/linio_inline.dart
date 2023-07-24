part of linio;

class LinioInlineBuilder {
  final Linio linio;
  final List<String> params = [];

  LinioInlineBuilder._(this.linio);

  factory LinioInlineBuilder.b({String name = 'main'}) {
    return LinioInlineBuilder._(Linio.instance(name));
  }

  LinioInlineBuilder t(String tag) {
    params.add('-t $tag');
    return this;
  }

  LinioInlineBuilder get d => level(LinioLogLevel.debug);

  LinioInlineBuilder get i => level(LinioLogLevel.info);

  LinioInlineBuilder get w => level(LinioLogLevel.warn);

  LinioInlineBuilder get e => level(LinioLogLevel.error);

  LinioInlineBuilder get f => level(LinioLogLevel.fatal);

  LinioInlineBuilder get s => mode(LinioLogType.static);

  LinioInlineBuilder get l => mode(LinioLogType.live);

  LinioInlineBuilder level(LinioLogLevel level) {
    String value;
    switch (level) {
      case LinioLogLevel.debug:
        value = 'd';
        break;
      case LinioLogLevel.info:
        value = 'i';
        break;
      case LinioLogLevel.warn:
        value = 'w';
        break;
      case LinioLogLevel.error:
        value = 'e';
        break;
      case LinioLogLevel.fatal:
        value = 'f';
        break;
    }
    params.add('-l $value');
    return this;
  }

  LinioInlineBuilder mode(LinioLogType type) {
    String value;
    switch (type) {
      case LinioLogType.live:
        value = 'l';
        break;
      case LinioLogType.static:
        value = 's';
        break;
    }
    params.add('-m $value');
    return this;
  }

  logPoint() {
    linio.command('log_point');
  }

  log(dynamic logOrCommand) {
    String options = params.join(' ');
    options = options.isNotEmpty ? "$options $logOrCommand" : logOrCommand;
    linio.log(options);
  }

  command(String command) {
    linio.command(command);
  }
}
