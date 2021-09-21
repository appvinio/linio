import 'package:linio/linio.dart';
import 'package:test/test.dart';

import '../linio_test.dart';
import '../mock/mocks.dart';

void main() {
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
}
