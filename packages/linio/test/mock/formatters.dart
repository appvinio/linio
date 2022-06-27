import 'package:linio/linio.dart';

class TestFormatter extends LinioFormatter {
  @override
  List<String> format(log) {
    return (log as String).split('');
  }

  @override
  bool handleLog(log) {
    return true;
  }
}
