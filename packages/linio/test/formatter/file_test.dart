import 'dart:io';

import 'package:linio/linio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mock/mocks.dart';

class MockFile extends Mock implements File {}

void main() {
  group('formatter test', () {
    final testFormatter = FileLinioFormatter();
    final mockFile = MockFile();
    test('single formatter', () {
      final console = TestConsole();
      final date = DateTime(2020);
      when(() => mockFile.lastAccessedSync()).thenReturn(date);
      when(() => mockFile.lastModifiedSync()).thenReturn(date);
      when(() => mockFile.existsSync()).thenReturn(false);
      when(() => mockFile.lengthSync()).thenReturn(0);
      when(() => mockFile.absolute).thenReturn(mockFile);
      when(() => mockFile.path).thenReturn('TEST');
      Linio linio = Linio.custom(printers: [console], formatters: [testFormatter]);
      linio.log(mockFile);
      expect(console.logs, [
        'File name: TEST',
        'File exists: false',
        'File size: 0',
        'File last accessed: 2020-01-01T00:00:00.000',
        'File last modified: 2020-01-01T00:00:00.000',
      ]);
    });
  });
}
