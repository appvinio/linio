import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../linio_test.dart';
import '../mock/mocks.dart';

void main() {
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
}