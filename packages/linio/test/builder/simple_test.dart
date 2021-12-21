import 'dart:io';

import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

class MockFile extends Mock implements File{}

void main(){
  group('formatter test', () {

    final tagHeader = TagLinioHeader();
    final levelHeader = LevelLinioHeader();

    test('single formatter', () {
      final console = TestConsole();
      Linio.custom(printers: [console]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.log('test');
      expect(console.logs, ['test',]);
    });

    test('tag and level formatter', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [levelHeader, tagHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.t('TAG').l(LinioLogLevel.error).log('test');
      expect(console.logs, ['[ERROR] TAG test',]);
    });
  });

  group('inline tag test', () {

    final tagHeader = TagLinioHeader();

    test('tag formatter via tag method', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [tagHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.t('TAG').log('test');
      expect(console.logs, ['TAG test',]);
    });

    test('tag formatter via logOrCommand', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [tagHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.log('TAG', 'test');
      expect(console.logs, ['TAG test',]);
    });
  });

  group('inline level test', () {

    final levelHeader = LevelLinioHeader();

    test('single inline log', () {
      final console = TestConsole();
      Linio.custom(printers: [console]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.log('test');
      expect(console.logs, ['test',]);
    });

    test('inline param level test', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [levelHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.l(LinioLogLevel.error).log('test');
      expect(console.logs, ['[ERROR] test',]);
    });

    test('inline debug level test', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [levelHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.d.log('test');
      expect(console.logs, ['[DEBUG] test',]);
    });

    test('inline info level test', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [levelHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.i.log('test');
      expect(console.logs, ['[INFO ] test',]);
    });

    test('inline warn level test', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [levelHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.w.log('test');
      expect(console.logs, ['[WARN ] test',]);
    });

    test('inline error level test', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [levelHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.e.log('test');
      expect(console.logs, ['[ERROR] test',]);
    });

    test('inline fatal level test', () {
      final console = TestConsole();
      Linio.custom(printers: [console], headers: [levelHeader]);
      LinioInlineBuilder builder = LinioInlineBuilder.b(name: 'main');
      builder.f.log('test');
      expect(console.logs, ['[FATAL] test',]);
    });
  });
}