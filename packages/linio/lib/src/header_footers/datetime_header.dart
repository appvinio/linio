part of linio;

typedef DateTimeHeaderFormatter = String Function(DateTime dateTime);

final _defaultDateTimeFormatter = (DateTime dateTime) => dateTime.toIso8601String();

class DateTimeLinioHeader extends LinioHeaderFooter {
  final DateTimeProvider dateTimeProvider;
  final DateTimeHeaderFormatter formatter;

  DateTimeLinioHeader({
    this.dateTimeProvider = const DartDateTimeProvider(),
    DateTimeHeaderFormatter? formatter,
  }) : this.formatter = formatter ??= _defaultDateTimeFormatter;

  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return '${dateTimeProvider.datetime.toIso8601String()} $log';
  }
}

abstract class DateTimeProvider {
  DateTime get datetime;
}

class DartDateTimeProvider implements DateTimeProvider {
  const DartDateTimeProvider();

  @override
  DateTime get datetime => DateTime.now();
}
