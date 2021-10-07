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

  LinioInlineBuilder get d => l(LinioLogLevel.debug);
  LinioInlineBuilder get i => l(LinioLogLevel.info);
  LinioInlineBuilder get w => l(LinioLogLevel.warn);
  LinioInlineBuilder get e => l(LinioLogLevel.error);
  LinioInlineBuilder get f => l(LinioLogLevel.fatal);

  LinioInlineBuilder l(LinioLogLevel level) {
    String value;
    switch(level) {
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

  void log(String log) {
    linio.log(params.join(' '), log);
  }
}