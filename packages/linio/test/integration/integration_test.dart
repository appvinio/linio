import 'package:linio/linio.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

void main() {
  group('formatter with header test', () {
    final testFormatter = TestFormatter();
    final testHeader1 = TestHeader('===');

    test('simple header', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], formatters: [testFormatter], headers: [testHeader1]);
      linio.log('test');
      expect(console.logs, [
        '===t===',
        '===e===',
        '===s===',
        '===t===',
      ]);
    });
  });

  group('level and tag mixer test', () {
    final levelHeader = LevelLinioHeader();
    final tagHeader = TagLinioHeader();

    test('single formatter', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], headers: [levelHeader, tagHeader]);
      linio.log('-l fatal -t TEST test');
      expect(console.logs, [
        '[FATAL] TEST test',
      ]);
    });
  });
}
