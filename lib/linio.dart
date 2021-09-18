library linio;

import 'dart:async';
import 'dart:io';

import 'args/args.dart';
import 'args/command_runner.dart';

export 'args/args.dart';
export 'args/command_runner.dart';

part 'src/commands/empty_command.dart';

part 'src/commands/level_manager_command.dart';

part 'src/commands/linio_command.dart';

part 'src/commands/linio_command_runner.dart';

part 'src/commands/log_point_command.dart';

part 'src/commands/stopwatch_command.dart';

part 'src/commands/tag_manager_command.dart';

part 'src/filters/level_linio_filter.dart';

part 'src/filters/linio_filter.dart';

part 'src/filters/tag_linio_filter.dart';

part 'src/formatters/file_formatter.dart';

part 'src/formatters/linio_formatter.dart';

part 'src/formatters/simple_formatter.dart';

part 'src/header_footers/datetime_header.dart';

part 'src/header_footers/grep_console_header.dart';

part 'src/header_footers/linio_header_footer.dart';

part 'src/header_footers/live_linio_header.dart';

part 'src/header_footers/tag_header.dart';

part 'src/header_footers/uptime_header.dart';

part 'src/managers/linio_level_manager.dart';

part 'src/managers/linio_tag_manager.dart';

part 'src/manipulators/linio_manipulator.dart';

part 'src/options/linio_log_level.dart';

part 'src/options/linio_log_type.dart';

part 'src/options/linio_options.dart';

part 'src/printer/console_printer.dart';

part 'src/printer/linio_printer.dart';

part 'src/printer/terminal_printer.dart';

class Linio {
  Linio._({
    this.printers = const [],
    this.formatters = const [SimpleLinioFormatter()],
    this.headers = const [],
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
  }

  factory Linio.custom(
      {List<LinioPrinter> printers = const [],
      List<LinioFormatter> formatters = const [SimpleLinioFormatter()],
      List<LinioHeaderFooter> headers = const [],
      List<LinioCommand> manipulators = const [],
      List<LinioFilter> filters = const [],
      String name = 'main'}) {
    _instances[name] = Linio._(
      printers: printers,
      formatters: formatters,
      headers: headers,
      manipulators: manipulators,
      filters: filters,
    );
    return _instances[name]!;
  }

  factory Linio.console([String name = 'main']) {
    _instances[name] = Linio._(printers: [
      ConsolePrinter(),
    ]);
    return instance;
  }

  factory Linio([String name = 'main']) {
    return instance;
  }

  static Map<String, Linio> _instances = {};

  static Linio get instance => _instances['main']!;

  static late CommandRunner<List<String>> commandRunner;
  List<LinioHeaderFooter> headers;
  List<LinioCommand> manipulators;
  List<LinioPrinter> printers;
  List<LinioFormatter> formatters;
  List<LinioFilter> filters;
  LinioTagManager tagManager = LinioTagManager();
  LinioLevelManager levelManager = LinioLevelManager();

  late StreamController<Function> streamController;

  void log(dynamic logOrCommand, [dynamic log]) {
    final linioCommand = commandRunner.argParser
        .parse((log != null ? logOrCommand : (logOrCommand is String ? logOrCommand : '')).toString().split(' '));
    List<String> linioCommandResult;
    if (linioCommand.command?.name?.isNotEmpty == true) {
      linioCommandResult = commandRunner
              .run((log != null ? logOrCommand : (logOrCommand is String ? logOrCommand : '')).toString().split(' ')) ??
          [];
      if (log == null && logOrCommand != null) {
        logOrCommand = null;
      }
    } else {
      linioCommandResult = [];
    }

    final linioLog = log ?? logOrCommand;

    String linioTag = linioCommand['tag'] ?? log != null ? logOrCommand : '';

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
    final options = LinioOptions(linioLogType, linioLogLevel, linioTag, linioLog ?? '', linioCommand);
    if (instance.filters.any((element) => !element.shouldLog(options))) {
      return;
    }
    instance._print(linioCommand, linioCommandResult, linioLog, options);
  }

  void _print(ArgResults command, List<String> commandResult, dynamic log, LinioOptions options) {
    final formatter = formatters.firstWhere((element) => element.handleLog(log));
    printers.forEach((printer) => printer.print(command, [...commandResult, ...formatter.format(log)], options));
  }
}
