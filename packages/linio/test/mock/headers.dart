import 'package:linio/linio.dart';

class TestHeader extends LinioHeaderFooter {
  TestHeader(this.headerFooter);

  final String headerFooter;

  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return '$headerFooter$log$headerFooter';
  }
}
