import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'mock/mocks.dart';
import 'builder/simple_test.dart' as builder;
import 'filter/level_test.dart' as filter_level_test;
import 'filter/tag_test.dart' as filter_tag_test;
import 'formatter/file_test.dart' as formatter_file_test;
import 'formatter/simple_test.dart' as formatter_simple_test;
import 'header/date_test.dart' as header_date_test;
import 'header/level_test.dart' as header_level_test;
import 'header/simple_test.dart' as header_simple_test;
import 'header/tag_test.dart' as header_tag_test;
import 'header/uptime_test.dart' as header_uptime_test;
import 'integration/integration_test.dart' as integration_integration_test;
import 'tag/tag_manager_test.dart' as tag_tag_manager_test;
import 'log_point/simple_test.dart' as log_point_test;

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

  builder.main();
  filter_level_test.main();
  filter_tag_test.main();
  formatter_file_test.main();
  formatter_simple_test.main();
  header_date_test.main();
  header_level_test.main();
  header_simple_test.main();
  header_tag_test.main();
  header_uptime_test.main();
  integration_integration_test.main();
  tag_tag_manager_test.main();
  log_point_test.main();
}
