part of linio;

class UpTimeLinioHeader extends LinioHeaderFooter {
  final DateTimeProvider dateTimeProvider;
  late final upTimeStart = dateTimeProvider.datetime;

  UpTimeLinioHeader({this.dateTimeProvider = const DartDateTimeProvider()});

  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    final currentTime = dateTimeProvider.datetime;
    return "${currentTime.difference(upTimeStart).toString().split('.').first.padLeft(8, "0")} $log";
  }
}
