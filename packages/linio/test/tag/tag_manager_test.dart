import 'package:linio/linio.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

void main() {
  group('tag header', () {

    final testHeader1 = TagLinioHeader();

    test('allow all', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], filters: [TagLinioFilter()], headers: [testHeader1]);
      final tagManager = linio.tagManager;
      tagManager.allow('all');
      linio.log('test', tag: 'TAG1');
      linio.log('test', tag: 'TAG2');
      linio.log('test', tag: 'TAG3');
      linio.log('test', tag: 'TAG4');
      expect(console.logs, ['TAG1 test','TAG2 test','TAG3 test','TAG4 test']);
    });

    test('allow all with except', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], filters: [TagLinioFilter()], headers: [testHeader1]);
      final tagManager = linio.tagManager;
      tagManager.allow('all');
      tagManager.block('TAG1');
      linio.log('test', tag: 'TAG1');
      linio.log('test', tag: 'TAG2');
      linio.log('test', tag: 'TAG3');
      linio.log('test', tag: 'TAG4');
      expect(console.logs, ['TAG2 test','TAG3 test','TAG4 test']);
    });

    test('block all', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], filters: [TagLinioFilter()], headers: [testHeader1]);
      final tagManager = linio.tagManager;
      tagManager.block('all');
      linio.log('test', tag: 'TAG1');
      linio.log('test', tag: 'TAG2');
      linio.log('test', tag: 'TAG3');
      linio.log('test', tag: 'TAG4');
      expect(console.logs, []);
    });

    test('block all with except', () {
      final console = TestConsole();
      Linio linio = Linio.custom(printers: [console], filters: [TagLinioFilter()], headers: [testHeader1]);
      final tagManager = linio.tagManager;
      tagManager.block('all');
      tagManager.allow('TAG1');
      linio.log('test', tag: 'TAG1');
      linio.log('test', tag: 'TAG2');
      linio.log('test', tag: 'TAG3');
      linio.log('test', tag: 'TAG4');
      expect(console.logs, ['TAG1 test']);
    });
  });
}