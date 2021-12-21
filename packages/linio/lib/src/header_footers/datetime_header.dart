part of linio;

class DateTimeLinioHeader extends LinioHeaderFooter {

  final DateTimeProvider dateTimeProvider;

  DateTimeLinioHeader({this.dateTimeProvider = const DartDateTimeProvider()});

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