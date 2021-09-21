import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../linio_test.dart';
import '../mock/mocks.dart';

void main() {
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
}
