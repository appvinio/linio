part of linio;

Linio get LC => Linio._instances['main']!;

LinioInlineBuilder get L => LinioInlineBuilder.b(name: 'main');

class Linio {
  Linio._({
    this.printers = const [],
    this.formatters = const [SimpleLinioFormatter()],
    this.headers = const [],
    this.plugins = const [],
    this.manipulators = const [],
    this.filters = const [],
  }) {
    streamController = StreamController<Function>();
    streamController.stream.asyncMap((event) => event()).listen((event) {});
    commandRunner = LinioCommandRunner('linio', 'linio');
    commandRunner.argParser.addOption('tag', abbr: 't');
    commandRunner.argParser.addOption('mode', abbr: 'm', allowed: ['s', 'l', 'static', 'live'], defaultsTo: 's');
    commandRunner.argParser.addOption('level',
        abbr: 'l', allowed: ['d', 'i', 'w', 'e', 'f', 'debug', 'info', 'warn', 'error', 'fatal'], defaultsTo: 'd');
    manipulators.forEach((element) {
      commandRunner.addCommand(element);
    });

    printers.forEach((printer) {
      printer.headers.addAll(headers);
    });

    filters.forEach((filter) {
      filter.init(this);
    });

    manipulators.forEach((manipulator) {
      manipulator.init(this);
    });

    plugins.forEach((plugin) {
      plugin.init(this);
    });
  }

  factory Linio.custom(
      {List<LinioPrinter> printers = const [],
      List<LinioFormatter> formatters = const [SimpleLinioFormatter()],
      List<LinioHeaderFooter> headers = const [],
      List<LinioCommand> manipulators = const [],
      List<LinioFilter> filters = const [],
      List<LinioPlugin> plugins = const [],
      String name = 'main'}) {
    _instances[name] = Linio._(
        printers: printers,
        formatters: formatters,
        headers: headers,
        manipulators: manipulators,
        filters: filters,
        plugins: plugins);
    return _instances[name]!;
  }

  factory Linio.init() {
    _instances['main'] = Linio._(
      printers: [
        ConsolePrinter(),
      ],
      formatters: [
        SimpleLinioFormatter(),
      ],
      headers: [
        AvoidFlutterHeader(),
        LevelLinioHeader(),
        TagLinioHeader(),
      ],
      manipulators: [
        LevelManagerCommand(),
        TagManagerCommand(),
      ],
      filters: [
        TagLinioFilter(),
        LevelLinioFilter(),
      ],
    );
    return _instances['main']!;
  }

  static Map<String, Linio> _instances = {};

  static Linio instance([String name = 'main']) => _instances[name]!;

  static late CommandRunner<List<String>> commandRunner;
  List<LinioHeaderFooter> headers;
  List<LinioCommand> manipulators;
  List<LinioPrinter> printers;
  List<LinioPlugin> plugins;
  List<LinioFormatter> formatters;
  List<LinioFilter> filters;
  LinioTagManager tagManager = LinioTagManager();
  LinioLevelManager levelManager = LinioLevelManager();

  late StreamController<Function> streamController;

  void command(dynamic command) {
    final linioCommand = commandRunner.argParser.parse((command).toString().split(' '));
    if (linioCommand.command?.name?.isNotEmpty == true) {
      final linioCommandResult = commandRunner.run((command).toString().split(' ')) ?? [];
      LinioLogType linioLogType = logType(linioCommand);
      LinioLogLevel linioLogLevel = logLevel(linioCommand);
      final options = LinioOptions(linioLogType, linioLogLevel, '');

      _print(linioCommand.command!, linioCommandResult, null, options);
    }
  }

  void log(dynamic message, {LinioOptions options = const LinioOptions.standard(), String? tag}) {
    final linioCommand = commandRunner.argParser
        .parse(message.toString().split(' '));
    // List<String> linioCommandResult;
    // if (linioCommand.command?.name?.isNotEmpty == true) {
    //   //   linioCommandResult = commandRunner
    //   //           .run((log != null ? logOrCommand : (logOrCommand is String ? logOrCommand : '')).toString().split(' ')) ??
    //   //       [];
    //   //   if (log == null && logOrCommand != null) {
    //   //     logOrCommand = null;
    //   //   }
    //   // } else {
    //   //   linioCommandResult = [];
    // }

    final linioLog = (message is String) ? (linioCommand.rest.isNotEmpty ? linioCommand.rest.first : '' ) : message;
    String linioTag = tag ?? linioCommand['tag'] ?? '';

    LinioLogType linioLogType = logType(linioCommand);
    LinioLogLevel linioLogLevel = logLevel(linioCommand);
    final options = LinioOptions(linioLogType, linioLogLevel, linioTag);
    if (filters.any((element) => !element.shouldLog(options))) {
      return;
    }
    _print(linioCommand, [], linioLog, options);
  }

  LinioLogType logType(ArgResults linioCommand) {
    LinioLogType linioLogType = LinioLogType.static;
    switch (linioCommand['mode']) {
      case 'l':
      case 'live':
        linioLogType = LinioLogType.live;
        break;
      case 's':
      case 'static':
        linioLogType = LinioLogType.static;
        break;
    }
    return linioLogType;
  }

  LinioLogLevel logLevel(ArgResults linioCommand) {
    LinioLogLevel linioLogLevel = LinioLogLevel.debug;
    switch (linioCommand['level']) {
      case 'd':
      case 'debug':
        linioLogLevel = LinioLogLevel.debug;
        break;
      case 'i':
      case 'info':
        linioLogLevel = LinioLogLevel.info;
        break;
      case 'w':
      case 'warn':
        linioLogLevel = LinioLogLevel.warn;
        break;
      case 'e':
      case 'error':
        linioLogLevel = LinioLogLevel.error;
        break;
      case 'f':
      case 'fatal':
        linioLogLevel = LinioLogLevel.fatal;
        break;
    }
    return linioLogLevel;
  }

  void _print(ArgResults command, List<String> commandResult, dynamic log, LinioOptions options) {
    final formatter = formatters.firstWhere((element) => element.handleLog(log));
    printers.forEach((printer) => printer.print(command, [...commandResult, if (log != null) ...formatter.format(log)], options));
  }
}
