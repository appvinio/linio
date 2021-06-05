library linio;

import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'args/args.dart';
export 'args/args.dart';
import 'args/command_runner.dart';
export 'args/command_runner.dart';

part 'src/options/linio_log_level.dart';
part 'src/options/linio_log_type.dart';
part 'src/options/linio_options.dart';
part 'src/managers/linio_level_manager.dart';
part 'src/managers/linio_tag_manager.dart';
part 'src/filters/linio_filter.dart';
part 'src/filters/tag_linio_filter.dart';
part 'src/filters/level_linio_filter.dart';
part 'src/commands/linio_command_runner.dart';
part 'src/commands/linio_command.dart';
part 'src/commands/empty_command.dart';
part 'src/commands/log_point_command.dart';
part 'src/commands/tag_manager_command.dart';
part 'src/commands/level_manager_command.dart';
part 'src/commands/stopwatch_command.dart';
part 'src/printer/linio_printer.dart';
part 'src/printer/console_printer.dart';
part 'src/printer/terminal_printer.dart';
part 'src/formatters/linio_formatter.dart';
part 'src/formatters/simple_formatter.dart';
part 'src/formatters/file_formatter.dart';
part 'src/header_footers/linio_header_footer.dart';
part 'src/header_footers/grep_console_header.dart';
part 'src/header_footers/uptime_header.dart';
part 'src/header_footers/datetime_header.dart';
part 'src/header_footers/live_live_header.dart';
part 'src/header_footers/tag_header.dart';
part 'src/manipulators/linio_manipulator.dart';

class Linio {
  Linio({
    this.printers = const [],
    this.formatters = const [SimpleLinioFormatter()],
    this.headers = const [],
    this.manipulators = const [],
    this.filters = const [],
  }) {
    instance = this;

    instance.streamController = StreamController<Function>();
    instance.streamController.stream
        .asyncMap((event) => event())
        .listen((event) {});
    instance.commandRunner = LinioCommandRunner('linio', 'linio');
    instance.commandRunner.argParser.addOption('tag', abbr: 't');
    instance.commandRunner.argParser.addOption('mode',
        abbr: 'm', allowed: ['s', 'l', 'static', 'live'], defaultsTo: 's');
    instance.commandRunner.argParser.addOption('level',
        abbr: 'l',
        allowed: [
          'd',
          'i',
          'w',
          'e',
          'f',
          'debug',
          'info',
          'warn',
          'error',
          'fatal'
        ],
        defaultsTo: 'd');
    instance.manipulators.forEach((element) {
      instance.commandRunner.addCommand(element);
    });

    printers.forEach((printer) {
      printer.headers.addAll(headers);
    });
  }

  factory Linio.console() {
    instance = Linio(printers: [
      ConsolePrinter(),
    ]);
    return instance;
  }

  static late Linio instance;

  late CommandRunner<List<String>> commandRunner;
  List<LinioHeaderFooter> headers;
  List<LinioCommand> manipulators;
  List<LinioPrinter> printers;
  List<LinioFormatter> formatters;
  List<LinioFilter> filters;
  LinioTagManager tagManager = LinioTagManager();
  LinioLevelManager levelManager = LinioLevelManager();

  late StreamController<Function> streamController;

  static void log(dynamic logOrCommand, [dynamic log]) {
    final linioCommand = instance.commandRunner.argParser.parse((log != null
        ? logOrCommand
        : (logOrCommand is String ? logOrCommand : ''))
        .toString()
        .split(' '));
    List<String> linioCommandResult;
    if (linioCommand.command?.name?.isNotEmpty == true) {
      linioCommandResult = instance.commandRunner.run((log != null
          ? logOrCommand
          : (logOrCommand is String ? logOrCommand : ''))
          .toString()
          .split(' ')) ??
          [];
      if (log == null && logOrCommand != null) {
        logOrCommand = null;
      }
    } else {
      linioCommandResult = [];
    }

    final linioLog = log ?? logOrCommand;

    String linioTag = linioCommand['tag'] ?? '';

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
    final options = LinioOptions(linioLogType, linioLogLevel, linioTag);
    if (instance.filters.any((element) => !element.shouldLog(options))) {
      return;
    }
    instance._print(linioCommand, linioCommandResult, linioLog, options);
  }

  void _print(ArgResults command, List<String> commandResult, dynamic log,
      LinioOptions options) {
    final formatter =
    formatters.firstWhere((element) => element.handleLog(log));
    printers.forEach((printer) =>
        printer.print(
            command, [...commandResult, ...formatter.format(log)], options));
  }
}