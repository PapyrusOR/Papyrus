import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/data/local/file_storage.dart';

void main() {
  final testDir = Directory('${Directory.systemTemp.path}/papyrus_test_${DateTime.now().millisecondsSinceEpoch}');

  setUpAll(() async {
    await testDir.create(recursive: true);
  });

  tearDownAll(() async {
    if (await testDir.exists()) {
      await testDir.delete(recursive: true);
    }
  });

  group('FileStorage', () {
    test('writeAtomic writes content correctly', () async {
      final path = '${testDir.path}/atomic_test.json';
      const content = '{"hello":"world"}';
      await FileStorage.writeAtomic(path, content);

      final file = File(path);
      expect(await file.exists(), true);
      expect(await file.readAsString(), content);
      // .tmp file should not exist
      expect(await File('$path.tmp').exists(), false);
    });

    test('readJson returns correct map', () async {
      final path = '${testDir.path}/read_test.json';
      await FileStorage.writeJson(path, {'key': 'value', 'num': 42});
      final result = await FileStorage.readJson(path);
      expect(result, isNotNull);
      expect(result!['key'], 'value');
      expect(result['num'], 42);
    });

    test('readJson returns null for missing file', () async {
      final result = await FileStorage.readJson('${testDir.path}/nonexistent.json');
      expect(result, isNull);
    });

    test('writeJsonList and readJsonList roundtrip', () async {
      final path = '${testDir.path}/list_test.json';
      final list = [
        {'id': '1', 'name': 'A'},
        {'id': '2', 'name': 'B'},
      ];
      await FileStorage.writeJsonList(path, list);
      final result = await FileStorage.readJsonList(path);
      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0]['id'], '1');
      expect(result[1]['name'], 'B');
    });

    test('appendString appends lines', () async {
      final path = '${testDir.path}/append_test.log';
      await FileStorage.appendString(path, 'line 1');
      await FileStorage.appendString(path, 'line 2');
      final content = await File(path).readAsString();
      expect(content, 'line 1\nline 2\n');
    });
  });
}
