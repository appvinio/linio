import 'package:linio/linio.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

void main(){
  group('formatter test', () {
    test('single formatter', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], manipulators: [TagManagerCommand()], filters: [TagLinioFilter()]);
      linio.log('-t TAG1', 'TEST1');
      linio.log('tag_manager -a TAG1');
      linio.log('-t TAG1', 'TEST2');
      linio.log('tag_manager -b TAG1');
      linio.log('-t TAG1', 'TEST3');
      expect(console.logs, ['TEST1', 'TagManager: Allow TAG1', 'TEST2', 'TagManager: Block TAG1']);
    });
  });
}