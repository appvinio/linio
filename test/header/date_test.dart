import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../linio_test.dart';
import '../mock/mocks.dart';

void main() {
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
}