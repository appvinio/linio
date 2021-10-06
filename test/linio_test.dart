import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'mock/mocks.dart';

class MockDateTimeProvider extends Mock implements DartDateTimeProvider{}

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


}
