import 'package:linio/linio.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

void main() {
  group('formatter test', () {
    final testFormatter = TestFormatter();
    test('single formatter', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], formatters: [testFormatter]);
      linio.log('test');
      expect(console.logs, [
        't',
        'e',
        's',
        't',
      ]);
    });
  });
}
