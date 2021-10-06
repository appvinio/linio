part of linio;

class LinioInlineBuilder {
  final Linio linio;
  final Map<String, String> params = {};

  LinioInlineBuilder._(this.linio);

  factory LinioInlineBuilder.b({String name = 'main'}) {
    return LinioInlineBuilder._(Linio._());
  }

  LinioInlineBuilder t(String tag) {
    params.update('-t', (value) => tag, ifAbsent: () => tag);
    return this;
  }

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
    params.update('-l', (value) => value, ifAbsent: () => value);
    return this;
  }

  void log(String log) {
    //TODO Rafał
    // linio.log(logOrCommand)
  }



}