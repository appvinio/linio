import 'package:linio/linio.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

void main(){
  group('formatter test', () {
    test('single test', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], manipulators: [LevelManagerCommand()], filters: [LevelLinioFilter()]);
      linio.log('-l d TEST1');
      linio.command('level_manager -a debug');
      linio.log('-l d TEST2');
      linio.command('level_manager -b debug');
      linio.log('-l d TEST3');
      expect(console.logs, ['TEST1', 'TEST2']);
    });

    test('disable and reenable test', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], manipulators: [LevelManagerCommand()], filters: [LevelLinioFilter()]);
      linio.log('-l d TEST1');
      linio.command('level_manager -b debug');
      linio.log('-l d TEST2');
      linio.command('level_manager -a debug');
      linio.log('-l d TEST3');
      expect(console.logs, ['TEST1', 'TEST3']);
    });
  });
}