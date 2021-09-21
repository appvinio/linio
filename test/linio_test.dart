import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDateTimeProvider extends Mock implements DateTimeProvider{}

class TestConsole extends LinioPrinter {
  final List<String> logs = [];

  @override
  void printLog(ArgResults command, List<String> log, LinioOptions options) {
    logs.addAll(log);
    log.forEach(print);
  }
}

class TestHeader extends LinioHeaderFooter {

  TestHeader(this.headerFooter);

  final String headerFooter;

  @override
  String prepareHeader(ArgResults command, String log, LinioOptions options) {
    return '$headerFooter$log$headerFooter';
  }
}

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

void main() {
  group('simple test', () {
    test('single text', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console]);
      linio.log('test');
      expect(console.logs, ['test']);
    });
    test('two logs text', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console]);
      linio.log('foo');
      linio.log('bar');
      expect(console.logs, ['foo', 'bar']);
    });
  });

  group('header test', () {
    final testHeader1 = TestHeader('===');
    final testHeader2 = TestHeader('---');
    test('single header', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], headers: [testHeader1]);
      linio.log('test');
      expect(console.logs, ['===test===']);
    });
    test('two logs text', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], headers: [testHeader1, testHeader2]);
      linio.log('foo');
      expect(console.logs, ['===---foo---===']);
    });
  });

  group('formatter test', () {
    final testFormatter = TestFormatter();
    test('single formatter', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], formatters: [testFormatter]);
      linio.log('test');
      expect(console.logs, ['t','e','s','t',]);
    });
  });

  group('formatter with header test', () {
    final testFormatter = TestFormatter();
    final testHeader1 = TestHeader('===');

    test('single formatter', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], formatters: [testFormatter], headers: [testHeader1]);
      linio.log('test');
      expect(console.logs, ['===t===','===e===','===s===','===t===',]);
    });
  });

  group('date header', () {

    final dateTimeProvider = MockDateTimeProvider();
    final testHeader1 = DateTimeLinioHeader(dateTimeProvider: dateTimeProvider);

    test('single formatter', () {
      when(() => dateTimeProvider.datetime).thenReturn(DateTime(2020));
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], headers: [testHeader1]);
      linio.log('test');
      expect(console.logs, ['2020-01-01T00:00:00.000 test',]);
    });
  });

  group('uptime header', () {

    final dateTimeProvider = MockDateTimeProvider();
    final testHeader1 = UpTimeLinioHeader(dateTimeProvider: dateTimeProvider);

    test('single formatter', () {
      final dates = [ DateTime(2021), DateTime(2020), DateTime(2022), DateTime(2023)];
      when(() => dateTimeProvider.datetime).thenAnswer((_) => dates.removeAt(0));
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], headers: [testHeader1]);
      linio.log('test');
      linio.log('test');
      expect(console.logs, ['8784:00:00 test', '17544:00:00 test',]);
    });
  });

  group('tag header', () {

    final testHeader1 = TagLinioHeader();

    test('single formatter', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], headers: [testHeader1]);
      linio.log('test');
      linio.log('TAG', 'test');
      expect(console.logs, ['test', 'TAG test']);
    });
  });
}
