import 'package:linio/linio.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

void main() {
  group('date header', () {
    final testHeader1 = LevelLinioHeader();

    test('single formatter', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], headers: [testHeader1]);
      linio.log('-l debug test1');
      linio.log('-l info test2');
      linio.log('-l warn test3');
      linio.log('-l error test4');
      linio.log('-l fatal test5');
      expect(console.logs, [
        '[DEBUG] test1',
        '[INFO ] test2',
        '[WARN ] test3',
        '[ERROR] test4',
        '[FATAL] test5',
      ]);
    });
  });
}
