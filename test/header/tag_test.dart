import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../linio_test.dart';
import '../mock/mocks.dart';

void main() {
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